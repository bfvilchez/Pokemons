import UIKit

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

struct Pokemon {
    
}

class PokemonAPI {
    var results = [PokemonResults]()
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    func fetchPokemons(completion: @escaping([PokemonResults]?, NSError?) -> Void) {
        guard let pokemonResults = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return }
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
                
                print(String(data: pokemonData, encoding: .utf8))
              //  completion(pokemons,nil)
                
            } catch let error as NSError {
                print("error decoding pokemons: \(error)")
                completion(nil,error)
                return
            }
        }.resume()
    }
}
let api = PokemonAPI()

api.fetchPokemons { (results, error) in
    if let error = error as NSError? {
        print("error fetching pokemons: \(error)")
        return
    }
    
    print(results)
}
