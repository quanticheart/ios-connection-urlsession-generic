//
//  NetworkError.swift
//  conection-generic
//
//  Created by Jonn Alves on 12/03/23.
//

import Foundation

struct ServiceError: ErrorProtocol {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? APIError.unknown.rawValue
        self._description = description
        self.code = code
    }
}
