//
//  RequestProtocol.swift
//  conection-generic
//
//  Created by Jonn Alves on 11/03/23.
//

import Foundation

protocol ResponseProtocol {
    associatedtype ObjectType
    var responseObject:ObjectType?{
        get set
    }
    var customClass:ObjectType.Type?{get set}
}
