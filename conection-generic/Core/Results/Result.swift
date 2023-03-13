//
//  Result.swift
//  conection-generic
//
//  Created by Jonn Alves on 12/03/23.
//

import Foundation

enum Result<Success> {
    case success(Success)
    case failure(_ error:ServiceError)
}

enum ResultNetwork<Success> {
    case success(Success)
    case failure(_ error:NetworkError)
}


