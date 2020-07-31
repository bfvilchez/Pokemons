//
//  PokemonCollectionTableViewCell.swift
//  Pokemons
//
//  Created by brian vilchez on 7/30/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit

class PokemonCollectionTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    static let identifier = String(describing: PokemonCollectionTableViewCell.self)
    private let pokemonImageQueue = OperationQueue()
    private  var pokemonSprites: PokemonImage?
    var pokemonApi: PokemonAPI?
    var pokemonResult: PokemonResults? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    // MARK: - Helper Methods
    private func updateViews() {
        guard let pokemon = pokemonResult else { return }
        pokemonNameLabel.text = pokemon.name.capitalized
        fetchPokemonSprites(forPokemon: pokemon.name)
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 20, left: 10, bottom: 10, right: 50)
    }
    
    // fetches the relevant sprites url for pokemon
    private func fetchPokemonSprites(forPokemon pokemon: String) {
        pokemonApi?.fetchPokemonImage(forPokemon: pokemon, completion: { (pokemon, error) in
            if let error = error as NSError? {
                print("error fetching pokemon: \(error)")
                return
            } else {
                DispatchQueue.main.async {
                    self.pokemonSprites = pokemon
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
}

// MARK: - collectionView DataSource and delegate
extension PokemonCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let pokemon = pokemonSprites else {return 0 }
        return pokemon.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell else { fatalError("failed to get proper cell")}
        cell.configureCellStyle()
        fetchImage(forCell: cell, forIndexPath: indexPath)
        return cell
    }
}

// MARK: - fetch image for CollectionViewCell
extension PokemonCollectionTableViewCell {
    
    // fetches images from sprites URL.
    private func fetchImage(forCell cell: PokemonCollectionViewCell, forIndexPath indexPath: IndexPath) {
        guard let imageURL = pokemonSprites?.images[indexPath.row] else { return }
        
        let blockOperation = BlockOperation {
            self.pokemonApi?.fetchImage(imageURL, completion: { (image, error) in
                if let error = error as NSError? {
                    print("error fetching pokemon: \(error)")
                    return
                } else {
                    DispatchQueue.main.async {
                        cell.pokemonImageView.image = image
                    }
                }
            })
        }
        
        pokemonImageQueue.addOperation(blockOperation)
    }
    
}

// MARK: - collectionView FlowLayout
extension PokemonCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 300, height: 400)
        return size
    }
}
