//
//  APIError.swift
//  conection-generic
//
//  Created by Jonn Alves on 13/03/23.
//

import Foundation

internal enum APIError: String {
    case sessionError = "sessionError"
    case parsingError = "parsingError"
    case missingDataError = "missingDataError"
    case requestError = "requestError"
    case timeoutError = "timeoutError"
    case offline = "offline"
    case internalServerError = "internalServerError"
    case notFound = "notFound"
    case genericError = "genericError"
    case badURL = "badURL"
    case noData = "noData"
    case networkConnectionLost = "offline 1"
    case cannotConnectToHost = "offline 2"
    case notConnectedToInternet = "offline 3"
    case unknown = "unknown"
}
