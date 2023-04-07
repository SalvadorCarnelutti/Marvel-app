//
//  CharactersInteractorMock.swift
//  Marvel appTests
//
//  Created by Salvador on 4/6/23.
//

import XCTest
@testable import Marvel_app

class CharactersInteractorMock: CharactersPresenterToInteractorProtocol {
    var loadCharactersShouldSucceed = true
    var loadComicsShouldSucceed = true
    
    var loadCharactersCount = 0
    var loadCharactersSuccessCount = 0
    var loadCharactersFailureCount = 0
    
    var loadComicsCount = 0
    var loadComicsSuccessCount = 0
    var loadComicsFailureCount = 0
    
    var presenter: BaseViewProtocol?
    
    func loadCharacters(onCompletion completionHandler: @escaping (Result<[Character], Error>) -> ()) {
        loadCharactersCount += 1
        if loadCharactersShouldSucceed {
            loadCharactersSuccessCount += 1
            completionHandler(.success([Character.mockCharacter(id: loadCharactersSuccessCount)]))
        } else {
            loadCharactersFailureCount += 1
            completionHandler(.failure(MockError.error("Character error")))
        }
    }
    
    func loadComicsFor(characterId: Int, onCompletion completionHandler: @escaping (Result<[String], Error>) -> ()) {
        loadComicsCount += 1
        if loadComicsShouldSucceed {
            loadComicsSuccessCount += 1
            completionHandler(.success([]))
        } else {
            loadComicsFailureCount += 1
            completionHandler(.failure(MockError.error("Comic error")))
        }
    }
    
    func clean() {
        loadCharactersCount = 0
        loadCharactersSuccessCount = 0
        loadCharactersFailureCount = 0
        
        loadComicsCount = 0
        loadComicsSuccessCount = 0
        loadComicsFailureCount = 0
    }
}

enum MockError: Error {
    case error(String)
}

extension Character {
    static func mockCharacter(id: Int) -> Character {
        Character(id: id,
                  thumbnail: Image(path: "", fileExtension: ""),
                  name: "",
                  description: nil)
    }
}
