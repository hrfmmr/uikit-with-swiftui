import Foundation

enum PokemonType: String, CaseIterable, Identifiable {
    case fire, water, electric

    var id: String { rawValue }
}

struct Pokemon: Identifiable, Equatable {
    let name: String

    var id: String { name }
}
