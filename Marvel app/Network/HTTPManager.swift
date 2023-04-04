//
//  HTTPManager.swift
//  Marvel app
//
//  Created by Salvador on 4/4/23.
//

import Foundation
import Alamofire

protocol HTTPManagerProtocol {
    func queryGet(_ url: String, params: [String: Any]?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void)
    func get(_ url: String, params: [String: Any]?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void)
    func put(_ url: String, params: [String: Any]?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void)
    func post(_ url: String, params: [String: Any]?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void)
}

class HTTPManager: HTTPManagerProtocol {
    func queryGet(_ url: String, params: [String: Any]?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void) {
        performHTTPMethod(URLEncoding.default,
                          url: url,
                          params: params,
                          headers: nil,
                          onCompletion: completionHandler,
                          method: .get)
    }
    
    func get(_ url: String, params: [String: Any]?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void) {
        performHTTPMethod(JSONEncoding.default,
                          url: url,
                          params: params,
                          headers: nil,
                          onCompletion: completionHandler,
                          method: .get)
    }
    
    func put(_ url: String, params: [String: Any]?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void) {
        performHTTPMethod(JSONEncoding.default,
                          url: url,
                          params: params,
                          headers: nil,
                          onCompletion: completionHandler,
                          method: .put)
    }
    
    func post(_ url: String, params: [String: Any]?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void) {
        performHTTPMethod(JSONEncoding.default,
                          url: url,
                          params: params,
                          headers: nil,
                          onCompletion: completionHandler,
                          method: .post)
    }
    
    private func performHTTPMethod(_ encoding: ParameterEncoding, url: String, params: [String: Any]?, headers: HTTPHeaders?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void, method: HTTPMethod) {
        AF.request(url, method: method, parameters: params, encoding: encoding, headers: headers, interceptor: nil, requestModifier: nil).responseData { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
