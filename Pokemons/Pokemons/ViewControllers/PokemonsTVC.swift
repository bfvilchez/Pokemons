//
//  PokemonsTVC.swift
//  Pokemons
//
//  Created by brian vilchez on 7/30/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit

class PokemonsTVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private let mockData = [ Person(name: "Brian", familyMembers: ["Dana", "Arian","Jesse", "Nathan"])]
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - helper Methods
    private func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

// MARK: - TableView DataSource
extension PokemonsTVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCollectionTableViewCell.identifier, for: indexPath) as? PokemonCollectionTableViewCell else { fatalError("could not dequeue proper cell")}
        let person = mockData[indexPath.row]
        cell.person = person
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}


struct Person {
    
    let name: String
    let familyMembers: [String]
}
