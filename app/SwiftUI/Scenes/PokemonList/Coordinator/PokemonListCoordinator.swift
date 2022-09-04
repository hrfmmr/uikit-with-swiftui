import Combine
import Foundation
import UIKit

class PokemonListCoordinator: MainCoordinator {
    private weak var parent: UIViewController?
    private let diContainer: DIContainer
    private var cancellables = Set<AnyCancellable>()

    init(
        parent: UIViewController,
        diContainer: DIContainer
    ) {
        self.parent = parent
        self.diContainer = diContainer
        super.init(navigator: UINavigationController())
    }

    override func start() {
        super.start()
        guard let parent = parent else { return }
        let pokemonListBuilder = diContainer.viewBuilderContainer.pokemonList
        pokemonListBuilder.routeEvent
            .sink { [weak self] routing in
                switch routing {
                case let .pokemonDetails(pokemon):
                    self?.coordinateToPokemonDetails(for: pokemon)
                }
            }
            .store(in: &cancellables)
        let vc = pokemonListBuilder.build(from: self)
        navigator.viewControllers = [vc]
        parent.setContentViewController(navigator)
    }

    override func finish() {
        super.finish()
        guard let vc = parent?.children.compactMap({ $0 as? PokemonListHostingVC }).first else { return }
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
}

private extension PokemonListCoordinator {
    func coordinateToPokemonDetails(for pokemon: Pokemon) {
        let pokemonDetailsCoordinator = PokemonDetailsCoordinator(
            context: .init(pokemon: pokemon),
            navigator: navigator,
            diContainer: diContainer
        )
        coordinate(to: pokemonDetailsCoordinator)
    }
}
