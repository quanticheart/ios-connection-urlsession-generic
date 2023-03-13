//
//  Config.swift
//  conection-generic
//
//  Created by Jonn Alves on 12/03/23.
//

import Foundation

class ConfigPokemonApi : ApiConfigProtocol {
    var baseUrl: String? = "https://pokeapi.co/api/v2"
    
    func headers() -> HTTPHeaders {
        var h =  self.createHeaders()
        h["test"] = "valur"
        return h
    }
}
