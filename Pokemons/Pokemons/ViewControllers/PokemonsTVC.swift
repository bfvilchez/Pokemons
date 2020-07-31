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
    private(set) var pokemonAPI = PokemonAPI()
    private var pokemons = [PokemonResults]()
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        navBarConfigure()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - helper Methods
    private func configureViews() {
        pokemonAPI.fetchPokemons { (results, error) in
            if let error = error as NSError? {
                print("error fetching pokemons: \(error)")
                return
            } else {
                DispatchQueue.main.async {
                    self.pokemons = results!
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9921568627, blue: 0.9921568627, alpha: 1)
    }
    
    private func navBarConfigure() {
        navigationController?.navigationBar.barTintColor = UIColor.systemRed
        navigationController?.navigationBar.backgroundColor = .systemRed
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

// MARK: - TableView DataSource
extension PokemonsTVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCollectionTableViewCell.identifier, for: indexPath) as? PokemonCollectionTableViewCell else { fatalError("could not dequeue proper cell")}
        
        let pokemon = pokemons[indexPath.row]
        cell.pokemonApi = pokemonAPI
        cell.pokemonResult = pokemon
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}
