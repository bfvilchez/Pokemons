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
    @IBOutlet weak var pokemonImageView: UIImageView!
    var pokemonAPI: PokemonAPI? 
    var pokemonImageURL: String? {
        didSet {
            updateViews()
            configureCellStyle()
        }
    }
    
    private func updateViews() {
        guard let pokemonImageURL = pokemonImageURL else { return }
        pokemonAPI?.fetchImage(pokemonImageURL, completion: { (image, error) in
            if let error = error as NSError? {
                print("error fetching pokemon: \(error)")
                return
            } else {
                DispatchQueue.main.async {
                    self.pokemonImageView.image = image
                }
            }
        })
    }
    
    private func configureCellStyle() {
        
        self.layer.cornerRadius = 30
        self.layer.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.layer.shadowColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 0.8982769692)
        self.layer.shadowOffset = CGSize(width: 2.0, height: 5.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false
    }
    
}
