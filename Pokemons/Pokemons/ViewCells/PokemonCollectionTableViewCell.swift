//
//  PokemonCollectionTableViewCell.swift
//  Pokemons
//
//  Created by brian vilchez on 7/30/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit

class PokemonCollectionTableViewCell: UITableViewCell {

    static let identifier = String(describing: PokemonCollectionTableViewCell.self)
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var person: Person? {
        didSet {
            updateViews()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        updateViews()
    }

    private func updateViews() {
        pokemonNameLabel.text = person?.name
        collectionView.reloadData()
    }

}

// MARK: - collectionView DataSource and delegate
extension PokemonCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let person = person else { return 0 }
        return person.familyMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell else { fatalError("failed to get proper cell")}
        let member = person?.familyMembers[indexPath.row]
        cell.backgroundColor = .red
        cell.pokemonName.text = member
        return cell
    }
}

// MARK: - collectionView FlowLayout
extension PokemonCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 130, height: 130)
        return size
    }
}
