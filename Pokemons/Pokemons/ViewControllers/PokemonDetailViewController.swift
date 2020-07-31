//
//  PokemonDetailViewController.swift
//  Pokemons
//
//  Created by brian vilchez on 7/30/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var pokemonView: UIView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    var pokemonApi: PokemonAPI?
    var pokemonName: String?
    var image: String? {
        didSet {
            fetchImage()
        }
    }
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePokemonView()
        fetchImage()
    }
    
    // MARK: Methods 
    private func configurePokemonView() {
        pokemonView.backgroundColor =  #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        pokemonView.layer.cornerRadius = 30
    }

    private func fetchImage() {
        guard let image = image else { return }
        pokemonApi?.fetchImage(image, completion: { (image, error) in
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
    
    @IBAction func dismissCardView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
