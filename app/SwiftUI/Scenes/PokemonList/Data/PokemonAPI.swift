import Foundation

protocol PokemonAPI {
    func getPokemons(for type: PokemonType) async throws -> [Pokemon]
}

struct PokemonAPIMock: PokemonAPI {
    func getPokemons(for type: PokemonType) async throws -> [Pokemon] {
        try await Task.sleep(nanoseconds: 500_000_000)
        let names: [String] = {
            switch type {
            case .fire:
                return ["charmander", "charmeleon", "charizard"]
            case .water:
                return ["squirtle", "wartortle", "blastoise"]
            case .electric:
                return ["pikachu", "raichu", "magnemite"]
            }
        }()
        return names.map(Pokemon.init(name:))
    }
}
