//
//  CharactersViewMock.swift
//  Marvel appTests
//
//  Created by Salvador on 4/6/23.
//

import XCTest
@testable import Marvel_app

class CharactersViewMock: UIView, CharactersPresenterToViewProtocol {
    var presenter: CharactersViewToPresenterProtocol?
    
    func loadView() {
        
    }
    
    func insertRows(at newIndexPaths: [IndexPath]) {
        
    }
}
