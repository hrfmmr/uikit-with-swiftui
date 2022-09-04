import SwiftUI

struct PokemonListContentView: View {
    @Environment(\.pokemonListSceneDIContainer) private var diContainer: PokemonListSceneDIContainer
    @EnvironmentObject var listState: PokemonListState
    private var interactor: PokemonListInteractor { diContainer.pokemonListInteractor }

    var body: some View {
        VStack {
            content
            Spacer()
        }
        .onChange(of: listState.selectingType) { newValue in
            reloadPokemons(for: newValue)
        }
    }

    @ViewBuilder private var content: some View {
        pokemonTypePicker
        pokemonList
    }

    private var pokemonTypePicker: some View {
        VStack(alignment: .leading) {
            Text("Select Pokemon Type")
            Picker("PokemonType", selection: $listState.selectingType) {
                ForEach(PokemonType.allCases) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding()
    }

    private var pokemonList: some View {
        PokemonListView()
    }

    // Side Effects

    private func reloadPokemons(for type: PokemonType) {
        interactor.reloadPokemons(for: type)
    }
}

struct PokemonListView: View {
    @Environment(\.pokemonListSceneDIContainer) private var diContainer: PokemonListSceneDIContainer
    @EnvironmentObject var listState: PokemonListState
    private var currentSelection: PokemonType { listState.selectingType }
    private var pokemons: Loadable<[Pokemon]> { listState.pokemons }
    private var interactor: PokemonListInteractor { diContainer.pokemonListInteractor }

    var body: some View {
        content
    }

    @ViewBuilder private var content: some View {
        switch pokemons {
        case .notRequested:
            notRequestedView
        case .isLoading:
            loadingView
        case let .loaded(pokemons):
            loadedView(pokemons)
        case let .failed(error):
            failedView(error)
        }
    }

    private var notRequestedView: some View {
        Text("")
            .onAppear { loadPokemons() }
    }

    private var loadingView: some View {
        VStack {
            Text("Loading...")
                .font(.footnote)
        }
    }

    private func loadedView(_ pokemons: [Pokemon]) -> some View {
        List(pokemons) { pokemon in
            HStack {
                Text(pokemon.name)
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                print("pokemon:\(pokemon.name) selected!")
                routeToDetails(for: pokemon)
            }
        }
    }

    private func failedView(_ error: Error) -> some View {
        Text("❗️error:\(error.localizedDescription)")
    }

    // Side Effects

    private func loadPokemons() {
        interactor.reloadPokemons(for: currentSelection)
    }

    private func routeToDetails(for pokemon: Pokemon) {
        interactor.didSelectPokemon(pokemon)
    }
}

#if DEBUG

    struct PokemonList_Previews: PreviewProvider {
        static let devices = [
            "iPhone 13 Pro Max",
//        "iPhone SE (3rd generation)",
        ]

        struct Wrapper: View {
            let diContainer: PokemonListSceneDIContainer
            var body: some View {
                PokemonListContentView()
                    .environment(\.pokemonListSceneDIContainer, diContainer)
                    .environmentObject(diContainer.sceneState.listState)
            }
        }

        static var previews: some View {
            Group {
                ForEach(devices, id: \.self) { device in
                    Wrapper(diContainer: .instance)
                        .previewDevice(PreviewDevice(rawValue: device))
                        .previewDisplayName(device)
                }
            }
        }
    }

#endif
