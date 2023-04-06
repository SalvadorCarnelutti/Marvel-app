//
//  CharactersPresenterMock.swift
//  Marvel appTests
//
//  Created by Salvador on 4/6/23.
//

import XCTest
@testable import Marvel_app

class CharactersPresenterMock: UIViewController, CharactersViewToPresenterProtocol {
    func didSelectCharacterAt(row: Int) {
        
    }
    
    func viewLoaded() {
        
    }
    
    func isPrefetching() {
        
    }
    
    var itemsCount: Int {
        return 0
    }
    
    func itemAt(row: Int) -> Item {
        return EventCellItem(id: 0, imageURL: URL(string: "")!, heading: "", startDate: nil)
    }
}
