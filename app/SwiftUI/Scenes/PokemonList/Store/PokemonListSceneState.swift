import Combine
import SwiftUI

struct PokemonListSceneState {
    var listState: PokemonListState = .init()
    var routingState: PokemonListRoutingState = .init()
}

class PokemonListState: ObservableObject {
    @Published var selectingType: PokemonType = .fire
    @Published var pokemons: Loadable<[Pokemon]> = .notRequested
}

enum PokemonListRouting: Equatable {
    case pokemonDetails(pokemon: Pokemon)
}

class PokemonListRoutingState {
    @Published var routing: PokemonListRouting?
}
