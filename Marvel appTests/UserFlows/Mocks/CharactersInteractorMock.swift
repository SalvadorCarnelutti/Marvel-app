//
//  CharactersInteractorMock.swift
//  Marvel appTests
//
//  Created by Salvador on 4/6/23.
//

import XCTest
@testable import Marvel_app

class CharactersInteractorMock: CharactersPresenterToInteractorProtocol {
    var presenter: BaseViewProtocol?
    
    func loadCharacters(onSuccess: @escaping ([Marvel_app.Character]) -> ()) {
        
    }
    
    func loadComicsFor(characterId: Int, onSuccess: @escaping ([String]) -> ()) {
        
    }
}
