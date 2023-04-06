//
//  HTTPManagerMock.swift
//  Marvel appTests
//
//  Created by Salvador on 4/6/23.
//

import XCTest
@testable import Marvel_app

class HTTPManagerMock: HTTPManagerProtocol {
    var queryGetCalled = false
    var queryGetURL: String?
    var queryGetParams: [String: Any]?
    var getCalled = false
    var getURL: String?
    var getParams: [String: Any]?
    var putCalled = false
    var putURL: String?
    var putParams: [String: Any]?
    var postCalled = false
    var postURL: String?
    var postParams: [String: Any]?
    
    func queryGet(_ url: String, params: [String : Any]?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void) {
        queryGetCalled = true
        queryGetURL = url
        queryGetParams = params
    }
    
    func get(_ url: String, params: [String : Any]?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void) {
        getCalled = true
        getURL = url
        getParams = params
    }
    
    func put(_ url: String, params: [String : Any]?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void) {
        putCalled = true
        putURL = url
        putParams = params
    }
    
    func post(_ url: String, params: [String : Any]?, onCompletion completionHandler: @escaping (Result<Data, Error>) -> Void) {
        postCalled = true
        postURL = url
        postParams = params
    }
    
    func clean() {
        queryGetCalled = false
        queryGetURL = nil
        queryGetParams = nil
        getCalled = false
        getURL = nil
        getParams = nil
        putCalled = false
        putURL = nil
        putParams = nil
        postCalled = false
        postURL = nil
        postParams = nil
    }
}
