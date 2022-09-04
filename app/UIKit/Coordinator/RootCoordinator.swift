import UIKit

class RootCoordinator: BaseCoordinator {
    private let window: UIWindow
    private let diContainer: DIContainer
    private lazy var rootVC = UIViewController()

    init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
    }

    override func start() {
        super.start()
        window.rootViewController = rootVC
        window.makeKeyAndVisible()

        coordinateToPokemonList()
    }
}

private extension RootCoordinator {
    func coordinateToPokemonList() {
        let pokemonListCoordinator = PokemonListCoordinator(
            parent: rootVC,
            diContainer: diContainer
        )
        coordinate(to: pokemonListCoordinator)
    }
}
