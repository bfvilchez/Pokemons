//
//  PokemonCollectionViewCell.swift
//  Pokemons
//
//  Created by brian vilchez on 7/30/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: PokemonCollectionViewCell.self)
    @IBOutlet weak var pokemonName: UILabel!
}
