import Combine
import Foundation
import UIKit

class PokemonDetailsCoordinator: BaseCoordinator {
    struct Context {
        let pokemon: Pokemon
    }

    private let context: Context
    private let navigator: UINavigationController
    private let diContainer: DIContainer

    init(
        context: Context,
        navigator: UINavigationController,
        diContainer: DIContainer
    ) {
        self.context = context
        self.navigator = navigator
        self.diContainer = diContainer
    }

    override func start() {
        super.start()
        let pokemonDetailsBuilder = diContainer.viewBuilderContainer.pokemonDetails
        let vc = pokemonDetailsBuilder.build(
            from: self,
            for: context.pokemon
        )
        navigator.pushViewController(vc, animated: true)
    }
}
