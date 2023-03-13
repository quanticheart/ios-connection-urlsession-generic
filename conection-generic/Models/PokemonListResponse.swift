// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemonList = try? JSONDecoder().decode(PokemonList.self, from: jsonData)

import Foundation

// MARK: - PokemonList
struct PokemonList: Codable {
    let count: Int
    let results: [Pokemon]
}

// MARK: - Result
struct Pokemon: Codable {
    let name: String
    let url: String
}
