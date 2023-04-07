//
//  EventsInteractorMock.swift
//  Marvel appTests
//
//  Created by Salvador on 4/7/23.
//

import XCTest
@testable import Marvel_app

class EventsInteractorMock: EventsPresenterToInteractorProtocol {
    var loadEventsShouldSucceed = true
    var loadComicsShouldSucceed = true
    
    var loadEventsCount = 0
    var loadEventsSuccessCount = 0
    var loadEventsFailureCount = 0
    
    var loadComicsCount = 0
    var loadComicsSuccessCount = 0
    var loadComicsFailureCount = 0
    
    var presenter: BaseViewProtocol?
    
    func loadEvents(onCompletion completionHandler: @escaping (Result<[Event], Error>) -> ()) {
        loadEventsCount += 1
        if loadEventsShouldSucceed {
            loadEventsSuccessCount += 1
            completionHandler(.success([Event.mockEvent(id: loadEventsSuccessCount)]))
        } else {
            loadEventsFailureCount += 1
            completionHandler(.failure(MockError.error("Event error")))
        }
    }
    
    func loadComicsFor(eventId characterId: Int, onCompletion completionHandler: @escaping (Result<[String], Error>) -> ()) {
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
        loadEventsCount = 0
        loadEventsSuccessCount = 0
        loadEventsFailureCount = 0
        
        loadComicsCount = 0
        loadComicsSuccessCount = 0
        loadComicsFailureCount = 0
    }
}

extension Event {
    static func mockEvent(id: Int) -> Event {
        Event(id: id,
              thumbnail: Image(path: "", fileExtension: ""),
              title: "",
              start: "")
    }
}
