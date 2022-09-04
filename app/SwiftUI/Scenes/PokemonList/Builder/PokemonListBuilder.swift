import Combine
import NeedleFoundation
import SwiftUI
import UIKit

protocol PokemonListBuilder {
    var routeEvent: AnyPublisher<PokemonListRouting, Never> { get }
    func build(from coordinator: BaseCoordinator) -> UIViewController
}

// MARK: Needle Dependency

protocol PokemonListDependency: Dependency {
    var pokemonListSceneDIContainer: PokemonListSceneDIContainer { get }
}

// MARK: Impl

class RealPokemonListBuilder: VCBuilder<PokemonListDependency>, PokemonListBuilder {
    private var routingState: PokemonListRoutingState { dependency.pokemonListSceneDIContainer.sceneState.routingState }

    var routeEvent: AnyPublisher<PokemonListRouting, Never> {
        routingState.$routing
            .print("↪️\(String(describing: type(of: self)))_routeEvent:")
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }

    func build(from coordinator: BaseCoordinator) -> UIViewController {
        PokemonListHostingVC(
            coordinator: coordinator,
            contentDIContainer: dependency.pokemonListSceneDIContainer
        )
    }
}

// MARK: Needle Component

class PokemonListComponent: Component<PokemonListDependency> {
    func pokemonListBuilder() -> PokemonListBuilder {
        RealPokemonListBuilder(dependency: dependency)
    }
}
