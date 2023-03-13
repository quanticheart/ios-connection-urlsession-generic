//
//  RequestProtocol.swift
//  conection-generic
//
//  Created by Jonn Alves on 11/03/23.
//

import Foundation

protocol ApiConfigProtocol {
    var baseUrl:String?{get}
    func timeout() -> Double
    func cachePolicy() -> NSURLRequest.CachePolicy
    func headers() -> HTTPHeaders
}

extension ApiConfigProtocol {
    func timeout() -> Double { return requestTimeOut }
    func cachePolicy() -> NSURLRequest.CachePolicy { return .reloadIgnoringLocalCacheData }
    
    public func createHeaders() -> HTTPHeaders {
        return [
            "application/json": "Content-Type"
        ]
    }
    
    public func headers() -> HTTPHeaders {
        return createHeaders()
    }
}
