//
//  ConnGeneric1.swift
//  conection-generic
//
//  Created by Jonn Alves on 11/03/23.
//

import Foundation

internal class NetworkHandler<Element>: NSObject  where Element:Encodable, Element:Decodable {
    
    typealias ResponseClosure = (ResultNetwork<Element>) -> Void
    typealias ResponseObjectType = Element
    
    var responseClosure:ResponseClosure?
    var configurationRequest:ApiConfigProtocol
    
    init(configurationRequest: ApiConfigProtocol) {
        self.configurationRequest = configurationRequest
    }
    
    var configuration:URLSessionConfiguration{
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: "bgTask \(String(describing: Element.self))")
        sessionConfig.isDiscretionary = true
        sessionConfig.allowsCellularAccess = true
        return sessionConfig
    }
    
    private var urlSession:URLSession {
        //        return  URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        return  URLSession(configuration: .default)
    }
    
    func getSession() -> URLSession {
        return urlSession
    }
    
    func post(_ path:String, body: JSON? = nil, customHeader: [String:String]? = nil, response: @escaping (ResultNetwork<Element>) -> Void){
        let url = makeUrl(path)
        request(url, .post, body: body, customHeader: customHeader, responseClosure: response)
    }
    
    func get(_ path:String, query: [String:String]? = nil, customHeader: [String:String]? = nil, response: @escaping (ResultNetwork<Element>) -> Void){
        let url = makeUrl(path)
        request(url, .get, query: query, customHeader: customHeader, responseClosure: response)
    }
    
    private func request(
        _ url:String,
        _ httpMethod : RequestMethod,
        query: [String:String]? = nil,
        body: JSON? = nil,
        customHeader: [String:String]? = nil,
        responseClosure: @escaping (ResultNetwork<Element>) -> Void
    ) {
        
        guard let urlObject = URL(string: url) else {
            responseClosure(.failure(NetworkError(title: "Error Url", description: APIError.badURL.rawValue, code: 4)))
            return
        }
        var request = URLRequest(url: urlObject)
        
        request.allHTTPHeaderFields = configurationRequest.headers()
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = configurationRequest.timeout()
        request.cachePolicy = configurationRequest.cachePolicy()
        
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        if query != nil {
            if var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false), !query!.isEmpty {
                urlComponents.queryItems = [URLQueryItem]()
                for (k, v) in query! {
                    let queryItem = URLQueryItem(name: k, value: "\(v)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
                request.url = urlComponents.url
            }
        }
        
        if customHeader != nil {
            if !customHeader!.isEmpty {
                for (k, v) in query! {
                    request.addValue(k, forHTTPHeaderField: v)
                }
            }
        }
        
        NetworkLogger.log(request: request)
        let task = getSession().dataTask(with: request) { data, response, error in
            NetworkLogger.log(response: response, data: data, error: error)
            handleResponse(data, response, error, responseClosure: responseClosure)
        }
        task.taskDescription = String(describing: Element.self)
        task.resume()
    }
    
    private func makeUrl(_ path :String, queryString:String?=nil)->String{
        var url = "\(configurationRequest.baseUrl ?? "empty")/\(path)"
        if queryString != nil {
            if url.contains("?") {
                url = "\(url)&\(queryString!)"
            } else {
                url = "\(url)?\(queryString!)"
            }
        }
        return url
    }
}
