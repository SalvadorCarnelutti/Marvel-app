//
//  RestClientTests.swift
//  Marvel appTests
//
//  Created by Salvador on 4/6/23.
//

import XCTest
@testable import Marvel_app

class RestClientTests: XCTestCase {
    private struct DummmyDTO: Codable {}
    private let httpManagerMock = HTTPManagerMock()
    private let dummyURL = ""
    private let dummyParams: [String: Any] = [:]
    
    override func tearDown() {
        httpManagerMock.clean()
    }
    
    func testQueryGet() {
        //given
        let restClient = RestClient<DummmyDTO>(httpManager: httpManagerMock)
        
        //when
        restClient.queryGet(dummyURL, params: dummyParams) { result in }
        
        //then
        XCTAssertTrue(httpManagerMock.queryGetCalled)
        XCTAssertEqual(httpManagerMock.queryGetURL, dummyURL)
        XCTAssertEqual(httpManagerMock.queryGetParams?.count, 0)
        XCTAssertFalse(httpManagerMock.getCalled)
        XCTAssertNil(httpManagerMock.getURL)
        XCTAssertNil(httpManagerMock.getParams)
        XCTAssertFalse(httpManagerMock.putCalled)
        XCTAssertNil(httpManagerMock.putURL)
        XCTAssertNil(httpManagerMock.putParams)
        XCTAssertFalse(httpManagerMock.postCalled)
        XCTAssertNil(httpManagerMock.postURL)
        XCTAssertNil(httpManagerMock.postParams)
    }
    
    func testGet() {
        //given
        let restClient = RestClient<DummmyDTO>(httpManager: httpManagerMock)
        
        //when
        restClient.get(dummyURL, params: dummyParams) { result in }
        
        //then
        XCTAssertTrue(httpManagerMock.getCalled)
        XCTAssertEqual(httpManagerMock.getURL, dummyURL)
        XCTAssertEqual(httpManagerMock.getParams?.count, 0)
        XCTAssertFalse(httpManagerMock.queryGetCalled)
        XCTAssertNil(httpManagerMock.queryGetURL)
        XCTAssertNil(httpManagerMock.queryGetParams)
        XCTAssertFalse(httpManagerMock.putCalled)
        XCTAssertNil(httpManagerMock.putURL)
        XCTAssertNil(httpManagerMock.putParams)
        XCTAssertFalse(httpManagerMock.postCalled)
        XCTAssertNil(httpManagerMock.postURL)
        XCTAssertNil(httpManagerMock.postParams)
    }
    
    func testPut() {
        //given
        let restClient = RestClient<DummmyDTO>(httpManager: httpManagerMock)
        
        //when
        restClient.put(dummyURL, params: dummyParams) { result in }
        
        //then
        XCTAssertTrue(httpManagerMock.putCalled)
        XCTAssertEqual(httpManagerMock.putURL, dummyURL)
        XCTAssertEqual(httpManagerMock.putParams?.count, 0)
        XCTAssertFalse(httpManagerMock.queryGetCalled)
        XCTAssertNil(httpManagerMock.queryGetURL)
        XCTAssertNil(httpManagerMock.queryGetParams)
        XCTAssertFalse(httpManagerMock.getCalled)
        XCTAssertNil(httpManagerMock.getURL)
        XCTAssertNil(httpManagerMock.getParams)
        XCTAssertFalse(httpManagerMock.postCalled)
        XCTAssertNil(httpManagerMock.postURL)
        XCTAssertNil(httpManagerMock.postParams)
    }
    
    func testPost() {
        //given
        let restClient = RestClient<DummmyDTO>(httpManager: httpManagerMock)
        
        //when
        restClient.post(dummyURL, params: dummyParams) { result in }
        
        //then
        XCTAssertTrue(httpManagerMock.postCalled)
        XCTAssertEqual(httpManagerMock.postURL, dummyURL)
        XCTAssertEqual(httpManagerMock.postParams?.count, 0)
        XCTAssertFalse(httpManagerMock.queryGetCalled)
        XCTAssertNil(httpManagerMock.queryGetURL)
        XCTAssertNil(httpManagerMock.queryGetParams)
        XCTAssertFalse(httpManagerMock.getCalled)
        XCTAssertNil(httpManagerMock.getURL)
        XCTAssertNil(httpManagerMock.getParams)
        XCTAssertFalse(httpManagerMock.putCalled)
        XCTAssertNil(httpManagerMock.putURL)
        XCTAssertNil(httpManagerMock.putParams)
    }
}
