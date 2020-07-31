//
//  PokemonImage.swift
//  Pokemons
//
//  Created by brian vilchez on 7/30/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import Foundation


struct PokemonImage: Decodable {
    let images: [String]
    
    private enum CodingKeys: String, CodingKey {
        case sprites
        
        enum SpritesCodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case backShiny = "back_shiny"
            case frontDefault = "front_default"
            case frontShiny = "front_shiny"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonImage.CodingKeys.self)
        let spritesContainer = try container.nestedContainer(keyedBy: PokemonImage.CodingKeys.SpritesCodingKeys.self, forKey: .sprites)
        let frontShiny = try spritesContainer.decode(String.self, forKey: .frontShiny)
        let backShiny = try spritesContainer.decode(String.self, forKey: .backShiny)
        let frontDefault = try spritesContainer.decode(String.self, forKey: .frontDefault)
        let backDefault = try spritesContainer.decode(String.self, forKey: .backDefault)
        self.images =  [frontShiny,backShiny,frontDefault,backDefault]
        
        
    }
}
