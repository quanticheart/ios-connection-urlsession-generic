//
//  HandleResponse.swift
//  conection-generic
//
//  Created by Jonn Alves on 13/03/23.
//

import Foundation

internal func handleResponse<Element>(_ data: Data?,_ response: URLResponse?,_ error: Error?, responseClosure: (ResultNetwork<Element>) -> Void) where Element:Encodable, Element:Decodable {
    
    if error != nil {
        responseClosure(.failure(handleError(error: error!)))
        return
    }
    
    if response != nil {
        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) && !(response.statusCode == 304) {
            responseClosure(.failure(handleHttpError(httpError: response.statusCode)))
            return
        }
    }
    
    guard let data = data else {
        responseClosure(.failure(NetworkError(title: "Error Data", description: APIError.noData.rawValue, code: 5)))
        return
    }
    
    do {
        if let jsonString = String(data: data, encoding: .utf8){
            let jsonData = jsonString.data(using: .utf8)!
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.dataDecodingStrategy = .base64
            let responseObject = try decoder.decode(Element.self, from: jsonData)
            responseClosure(.success(responseObject))
        }
    } catch _ {
        responseClosure(.failure(NetworkError(title: "Error Parsing", description: APIError.parsingError.rawValue, code: 6)))
    }
}

private func handleError(error:Error) -> NetworkError {
    var msg = APIError.unknown
    
    if error._code == -1009 {
        msg = APIError.offline
    } else {
        msg = APIError.sessionError
    }
    
    if error is URLError {
        switch (error as! URLError).code {
        case .timedOut:
            msg = APIError.timeoutError
        case .badURL:
            msg = APIError.badURL
        case .notConnectedToInternet:
            msg = APIError.offline
        case .unsupportedURL:
            msg = APIError.badURL
        case .unknown:
            msg = APIError.unknown
        case .networkConnectionLost:
            msg = APIError.networkConnectionLost
        case .cannotConnectToHost:
            msg = APIError.cannotConnectToHost
        case .notConnectedToInternet:
            msg = APIError.cannotConnectToHost
        default:
            msg = APIError.unknown
        }
    }
    
    return NetworkError(title: "Error", description: msg.rawValue, code: 10)
}

private func handleHttpError(httpError:Int) -> NetworkError {
    var msg = APIError.unknown
    switch HTTPStatus(rawValue: httpError) {
    case .requestTimeout:
        msg = APIError.timeoutError
    case .internalServerError:
        msg = APIError.internalServerError
    case .notFound:
        msg = APIError.notFound
    default:
        msg = APIError.unknown
    }
    return NetworkError(title: "Http Error", description: msg.rawValue, code: 11)
}
