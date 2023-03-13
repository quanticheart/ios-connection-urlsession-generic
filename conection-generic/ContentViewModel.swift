//
//  ConnViewModel.swift
//  conection-generic
//
//  Created by Jonn Alves on 11/03/23.
//

import Foundation

class ContentViewModel {
    
    let service = NetworkService<PokemonList>(configuration: ConfigPokemonApi())
    
    func feetList() {
        let query = [
            "limit":"2000",
            "offset":"0",
        ]
        service.get("pokemon", query: query) { response in
            response.onSuccess { response in
                print("*******Response********",response.count)
            }.onError { error in
                print("Person:\(error)")
            }
        }
    }
}
