import Foundation
import NeedleFoundation

// MARK: - DIContainer

struct DIContainer {
    let viewBuilderContainer: ViewBuilderContainer
}

// MARK: - ViewBuilderContainer

protocol ViewBuilderContainer {
    var pokemonList: PokemonListBuilder { get }
    var pokemonDetails: PokemonDetailsBuilder { get }
}

protocol ViewBuilderContainerDependency: Dependency {}

class ViewBuilderContainerComponent:
    Component<ViewBuilderContainerDependency>,
    ViewBuilderContainer
{
    var pokemonList: PokemonListBuilder {
        pokemonListComponent.pokemonListBuilder()
    }

    var pokemonDetails: PokemonDetailsBuilder {
        pokemonDetailsComponent.pokemonDetailsBuilder()
    }
}

// MARK: Sub-Components

extension ViewBuilderContainerComponent {
    var pokemonListComponent: PokemonListComponent {
        PokemonListComponent(parent: self)
    }

    var pokemonDetailsComponent: PokemonDetailsComponent {
        PokemonDetailsComponent(parent: self)
    }
}

// MARK: PokemonList Scene Dependency

extension ViewBuilderContainerComponent {
    var pokemonListSceneDIContainer: PokemonListSceneDIContainer {
        shared { .instance }
    }
}
