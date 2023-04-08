//
//  EventsViewMock.swift
//  Marvel appTests
//
//  Created by Salvador on 4/7/23.
//

import XCTest
@testable import Marvel_app

class EventsViewMock: UIView, EventsPresenterToViewProtocol {
    var didReloadTable = false
    var presenter: EventsViewToPresenterProtocol?
        
    func loadView() {
        presenter?.viewLoaded()
    }
    
    func reloadTableViewData() {
        didReloadTable = true
    }
    
    func clean() {
        didReloadTable = false
    }
}
