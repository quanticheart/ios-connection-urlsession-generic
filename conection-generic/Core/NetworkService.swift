//
//  Conn1Ext.swift
//  conection-generic
//
//  Created by Jonn Alves on 12/03/23.
//

import Foundation
import SwiftUI

class NetworkService<T> where T:Encodable, T:Decodable {
    var request: NetworkHandler<T>? = nil
    
    init(configuration: ApiConfigProtocol) {
        self.request = NetworkHandler<T>(configurationRequest: configuration)
    }
    
    func post(_ path:String, body: JSON? = nil, customHeader: [String:String]? = nil, response: @escaping (ResultNetwork<T>) -> Void) {
        request?.post(path, body: body, customHeader: customHeader, response:response)
    }
    
    func get(_ path:String, query: [String:String]? = nil, customHeader: [String:String]? = nil, response: @escaping (ResultNetwork<T>) -> Void) {
        request?.get(path, query: query, customHeader: customHeader, response:response)
    }
}

extension ResultNetwork where Success:Encodable, Success:Decodable  {
    func onSuccess(callback: @escaping (Success) -> Void) -> ResultNetwork<Success> {
        switch self {
        case .success(let response):
            callback(response.self)
        default : break
        }
        return self
    }
    
    @discardableResult
    func onError(callback: @escaping (Error) -> Void) -> ResultNetwork<Success> {
        switch self {
        case .failure(error: let error):
            callback(error)
        default : break
        }
        return self
    }
}
