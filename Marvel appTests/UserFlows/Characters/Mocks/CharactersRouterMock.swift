//
//  CharactersRouterMock.swift
//  Marvel appTests
//
//  Created by Salvador on 4/6/23.
//

import XCTest
@testable import Marvel_app

class CharactersRouterMock: CharactersPresenterToRouterProtocol {
    var didPushComics = false
    var viewController: UIViewController?
    
    func pushComics(with characterComics: CharacterComics) {
        didPushComics = true
    }
    
    func clean() {
        didPushComics = false
    }
}
