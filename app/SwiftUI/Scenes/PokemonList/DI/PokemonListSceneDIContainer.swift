import SwiftUI

struct PokemonListSceneDIContainer {
    let sceneState: PokemonListSceneState
    let pokemonListInteractor: PokemonListInteractor

    static var instance: Self {
        let sceneState: PokemonListSceneState = .init()
        return .init(
            sceneState: sceneState,
            pokemonListInteractor: .init(
                pokemons: sceneState.listState.loadableSubject(\.pokemons),
                routingState: sceneState.routingState,
                api: PokemonAPIMock()
            )
        )
    }
}

extension PokemonListSceneDIContainer: EnvironmentKey {
    static var defaultValue: Self {
        .instance
    }
}

extension EnvironmentValues {
    var pokemonListSceneDIContainer: PokemonListSceneDIContainer {
        get { self[PokemonListSceneDIContainer.self] }
        set { self[PokemonListSceneDIContainer.self] = newValue }
    }
}
