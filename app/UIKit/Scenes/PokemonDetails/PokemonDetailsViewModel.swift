import Combine
import UIKit

class PokemonDetailsViewModel: ViewModel {
    @Published private var pokemon: Pokemon

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }

    struct Input {}

    struct Output {
        let pokemon: AnyPublisher<Pokemon, Never>
    }

    func transform(input _: Input) -> Output {
        return .init(
            pokemon: $pokemon.eraseToAnyPublisher()
        )
    }
}
