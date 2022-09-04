import Foundation

struct PokemonListInteractor {
    let pokemons: LoadableSubject<[Pokemon]>
    let routingState: PokemonListRoutingState
    let api: PokemonAPI

    func reloadPokemons(for type: PokemonType) {
        pokemons.wrappedValue = .isLoading
        Task {
            do {
                let fetched = try await api.getPokemons(for: type)
                Task { @MainActor in
                    pokemons.wrappedValue = .loaded(fetched)
                }
            } catch {
                Task { @MainActor in
                    pokemons.wrappedValue = .failed(error)
                }
            }
        }
    }

    func didSelectPokemon(_ pokemon: Pokemon) {
        routingState.routing = .pokemonDetails(pokemon: pokemon)
    }
}
