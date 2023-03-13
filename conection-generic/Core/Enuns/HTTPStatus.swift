//
//  HTTPStatus.swift
//  conection-generic
//
//  Created by Jonn Alves on 13/03/23.
//

import Foundation
internal enum HTTPStatus: Int {
    case multipleChoices = 300
    case badRequest = 400
    case forbidden = 403
    case notFound = 404
    case requestTimeout = 408
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailabe = 503
    case gatewayTimeout = 504
}
