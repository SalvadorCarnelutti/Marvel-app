//
//  CharactersViewMock.swift
//  Marvel appTests
//
//  Created by Salvador on 4/6/23.
//

import XCTest
@testable import Marvel_app

class CharactersViewMock: UIView, CharactersPresenterToViewProtocol {
    var insertedRows: [IndexPath]?
    
    var presenter: CharactersViewToPresenterProtocol?
    
    func loadView() {
        presenter?.viewLoaded()
    }
    
    func insertRows(at newIndexPaths: [IndexPath]) {
        insertedRows = newIndexPaths
    }
    
    func clean() {
        insertedRows = nil
    }
}
