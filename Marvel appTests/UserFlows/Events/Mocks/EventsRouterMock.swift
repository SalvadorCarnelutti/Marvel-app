//
//  EventsRouterMock.swift
//  Marvel appTests
//
//  Created by Salvador on 4/7/23.
//

import XCTest
@testable import Marvel_app

class EventsRouterMock: EventsPresenterToRouterProtocol {
    var didPresentComics = false
    var viewController: UIViewController?
    
    func presentComics(with eventComics: Marvel_app.EventComics) {
        didPresentComics = true
    }
    
    func clean() {
        didPresentComics = false
    }
}
