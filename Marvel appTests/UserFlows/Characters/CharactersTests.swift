//
//  CharactersTests.swift
//  Marvel appTests
//
//  Created by Salvador on 4/6/23.
//

import XCTest
@testable import Marvel_app

class CharactersTests: XCTestCase {
    private let charactersInteractorMock = CharactersInteractorMock()
    private let charactersRouterMock = CharactersRouterMock()
    private let charactersViewMock = CharactersViewMock()
    
    override func tearDown() {
        charactersInteractorMock.clean()
        charactersRouterMock.clean()
        charactersViewMock.clean()
    }
    
    private func createSut() -> CharactersPresenter {
        let sut = CharactersPresenter()
        CharactersConfigurator.injectDependencies(view: charactersViewMock,
                                                  interactor: charactersInteractorMock,
                                                  presenter: sut,
                                                  router: charactersRouterMock)
        
        return sut
    }
    
    func testSuccessfulLoadCharacters() {
        charactersInteractorMock.loadCharactersShouldSucceed = true
        let _ = createSut()
        XCTAssertNil(charactersViewMock.insertedRows)
        XCTAssertEqual(charactersInteractorMock.loadCharactersCount, 0)
        XCTAssertEqual(charactersInteractorMock.loadCharactersSuccessCount, 0)
        XCTAssertEqual(charactersInteractorMock.loadCharactersFailureCount, 0)
        
        charactersViewMock.presenter?.viewLoaded()
        XCTAssertEqual(charactersInteractorMock.loadCharactersCount, 1)
        XCTAssertEqual(charactersInteractorMock.loadCharactersSuccessCount, 1)
        XCTAssertEqual(charactersInteractorMock.loadCharactersFailureCount, 0)
        
        charactersViewMock.presenter?.isPrefetching()
        XCTAssertEqual(charactersInteractorMock.loadCharactersCount, 2)
        XCTAssertEqual(charactersInteractorMock.loadCharactersSuccessCount, 2)
        XCTAssertEqual(charactersInteractorMock.loadCharactersFailureCount, 0)
    }
    
    func testUnsuccessfulLoadCharacters() {
        charactersInteractorMock.loadCharactersShouldSucceed = false
        let sut = createSut()
        XCTAssertNil(charactersViewMock.insertedRows)
        XCTAssertEqual(charactersInteractorMock.loadCharactersCount, 0)
        XCTAssertEqual(charactersInteractorMock.loadCharactersSuccessCount, 0)
        XCTAssertEqual(charactersInteractorMock.loadCharactersFailureCount, 0)
        
        charactersViewMock.presenter?.viewLoaded()
        XCTAssertEqual(charactersInteractorMock.loadCharactersCount, 1)
        XCTAssertEqual(charactersInteractorMock.loadCharactersSuccessCount, 0)
        XCTAssertEqual(charactersInteractorMock.loadCharactersFailureCount, 1)
        XCTAssertNil(charactersViewMock.insertedRows)
    }
    
    func testNewIndexPaths() {
        charactersInteractorMock.loadCharactersShouldSucceed = true
        let _ = createSut()
        XCTAssertNil(charactersViewMock.insertedRows)
        charactersViewMock.presenter?.viewLoaded()
        XCTAssertEqual(charactersViewMock.insertedRows, [[0, 0]])
        
        charactersViewMock.presenter?.isPrefetching()
        XCTAssertEqual(charactersViewMock.insertedRows, [[0, 1]])
    }
    
    func testSuccessfulLoadComics() {
        charactersInteractorMock.loadComicsShouldSucceed = true
        let sut = createSut()
        
        charactersViewMock.presenter?.viewLoaded()
        XCTAssertEqual(charactersInteractorMock.loadComicsCount, 0)
        XCTAssertEqual(charactersInteractorMock.loadComicsSuccessCount, 0)
        XCTAssertEqual(charactersInteractorMock.loadComicsFailureCount, 0)
        
        sut.didSelectCharacterAt(row: 0)
        XCTAssertEqual(charactersInteractorMock.loadComicsCount, 1)
        XCTAssertEqual(charactersInteractorMock.loadComicsSuccessCount, 1)
        XCTAssertEqual(charactersInteractorMock.loadComicsFailureCount, 0)
    }
    
    func testUnsuccessfulLoadComics() {
        charactersInteractorMock.loadComicsShouldSucceed = false
        let sut = createSut()
        charactersViewMock.presenter?.viewLoaded()
        XCTAssertEqual(charactersInteractorMock.loadComicsCount, 0)
        XCTAssertEqual(charactersInteractorMock.loadComicsSuccessCount, 0)
        XCTAssertEqual(charactersInteractorMock.loadComicsFailureCount, 0)
        
        sut.didSelectCharacterAt(row: 0)
        XCTAssertEqual(charactersInteractorMock.loadComicsCount, 1)
        XCTAssertEqual(charactersInteractorMock.loadComicsSuccessCount, 0)
        XCTAssertEqual(charactersInteractorMock.loadComicsFailureCount, 1)
    }
    
    func testRouterPush() {
        charactersInteractorMock.loadComicsShouldSucceed = true
        let sut = createSut()
        charactersViewMock.presenter?.viewLoaded()
        XCTAssertFalse(charactersRouterMock.didPushComics)
        
        sut.didSelectCharacterAt(row: 0)
        XCTAssertTrue(charactersRouterMock.didPushComics)
    }
}
