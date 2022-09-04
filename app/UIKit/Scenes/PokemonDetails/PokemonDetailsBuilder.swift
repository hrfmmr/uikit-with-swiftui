import NeedleFoundation
import UIKit

protocol PokemonDetailsBuilder {
    func build(from coordinator: BaseCoordinator, for pokemon: Pokemon) -> UIViewController
}

// MARK: Needle Dependency

protocol PokemonDetailsDependency: Dependency {}

// MARK: Impl

class RealPokemonDetailsBuilder: VCBuilder<PokemonDetailsDependency>, PokemonDetailsBuilder {
    func build(from coordinator: BaseCoordinator, for pokemon: Pokemon) -> UIViewController {
        let viewModel: PokemonDetailsViewModel = .init(pokemon: pokemon)
        return PokemonDetailsVC(
            coordinator: coordinator,
            viewModel: viewModel
        )
    }
}

// MARK: Needle Component

class PokemonDetailsComponent: Component<PokemonDetailsDependency> {
    func pokemonDetailsBuilder() -> PokemonDetailsBuilder {
        RealPokemonDetailsBuilder(dependency: dependency)
    }
}
