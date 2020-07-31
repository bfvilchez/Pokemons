//
//  PokemonAPI.swift
//  Pokemons
//
//  Created by brian vilchez on 7/30/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import Foundation
import UIKit

class PokemonAPI {
    var pokemons = [Pokemon]()
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    func fetchPokemons(completion: @escaping([PokemonResults]?, NSError?) -> Void) {
        guard let pokemonResults = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=50&limit=100") else { return }
        var request = URLRequest(url: pokemonResults)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // checking for errors
            if let error = error as NSError? {
                print("error fetching pokemons: \(error)")
                completion(nil,error)
                return
            }
            
            //checking for data
            guard let pokemonData = data else { return }
            
            // convert json into model object
            do {
                let decoder = JSONDecoder()
                let pokemons = try decoder.decode(Results.self, from: pokemonData)
                completion(pokemons.results,nil)
                
            } catch let error as NSError {
                print("error decoding pokemons: \(error)")
                completion(nil,error)
                return
            }
        }.resume()
    }
    
    func fetchPokemonDetails(forPokemon pokemon: String, completion: @escaping(Pokemon?,NSError?) ->Void) {
        guard let pokemonResults = URL(string: "https://pokeapi.co/api/v2/pokemon/")?.appendingPathComponent(pokemon) else { return }
        var request = URLRequest(url: pokemonResults)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // checking for errors
            if let error = error as NSError? {
                print("error fetching pokemon: \(error)")
                completion(nil,error)
                return
            }
            
            //checking for data
            guard let pokemonData = data else { return }
            
            // convert json into model object
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: pokemonData)
                completion(pokemon,nil)
                
            } catch let error as NSError {
                print("error decoding pokemons: \(error)")
                completion(nil,error)
                return
            }
        }.resume()
        
        
    }
    func fetchPokemonImage(forPokemon name: String, completion: @escaping(PokemonImage?, NSError?) -> Void = { _,_ in }) {
        let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")?.appendingPathComponent(name)
        guard let pokemonURL = baseURL else { return }
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // checking for errors
            if let error = error as NSError? {
                print("error fetching pokemons: \(error)")
                completion(nil,error)
                return
            }
            
            //checking for data
            guard let pokemonData = data else { return }
            
            // convert json into model object
            do {
                let decoder =  JSONDecoder()
                let images = try decoder.decode(PokemonImage.self, from: pokemonData)

                completion(images, nil)
            } catch let error as NSError {
                print("error decoding pokemons: \(error)")
                completion(nil,error)
            }
        }.resume()
    }
    
    func fetchImage(_ pokemonImage: String, completion: @escaping(UIImage?,NSError?) -> Void) {
        guard let imageURL = URL(string: pokemonImage) else { return }
        var request = URLRequest(url: imageURL)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // checking for errors
            if let error = error as NSError? {
                print("error fetching pokemons: \(error)")
                completion(nil,error)
                return
            }
            
            //checking for data
            guard let pokemonData = data else { return }
            let image = UIImage(data: pokemonData)
            completion(image, nil)
         
        }.resume()
    }
}
