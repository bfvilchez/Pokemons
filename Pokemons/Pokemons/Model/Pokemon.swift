//
//  Pokemon.swift
//  Pokemons
//
//  Created by brian vilchez on 7/30/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import Foundation

struct Results: Codable {
    let results: [PokemonResults]
}
struct PokemonResults: Codable {
    let name: String
    let url: URL
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonResults.CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let urlString = try container.decode(String.self, forKey: .url)
        url = URL(string: urlString)!
    }
}

struct Pokemon: Codable {
    let name: String
    
}
