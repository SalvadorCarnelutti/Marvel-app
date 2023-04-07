//
//  EventsTests.swift
//  Marvel appTests
//
//  Created by Salvador on 4/7/23.
//

import XCTest
@testable import Marvel_app

class EventsTests: XCTestCase {
    private let eventsInteractorMock = EventsInteractorMock()
    private let eventsRouterMock = EventsRouterMock()
    private let eventsViewMock = EventsViewMock()
    
    override func tearDown() {
        eventsInteractorMock.clean()
        eventsRouterMock.clean()
        eventsViewMock.clean()
    }
    
    private func createSut() -> EventsPresenter {
        let sut = EventsPresenter()
        EventsConfigurator.injectDependencies(view: eventsViewMock,
                                              interactor: eventsInteractorMock,
                                              presenter: sut,
                                              router: eventsRouterMock)
        
        return sut
    }
    
    func testSuccessfulLoadEvents() {
        eventsInteractorMock.loadEventsShouldSucceed = true
        let _ = createSut()
        XCTAssertEqual(eventsInteractorMock.loadEventsCount, 0)
        XCTAssertEqual(eventsInteractorMock.loadEventsSuccessCount, 0)
        XCTAssertEqual(eventsInteractorMock.loadEventsFailureCount, 0)
        
        eventsViewMock.presenter?.viewLoaded()
        XCTAssertEqual(eventsInteractorMock.loadEventsCount, 1)
        XCTAssertEqual(eventsInteractorMock.loadEventsSuccessCount, 1)
        XCTAssertEqual(eventsInteractorMock.loadEventsFailureCount, 0)
    }
    
    func testUnsuccessfulLoadEvents() {
        eventsInteractorMock.loadEventsShouldSucceed = false
        let _ = createSut()
        XCTAssertEqual(eventsInteractorMock.loadEventsCount, 0)
        XCTAssertEqual(eventsInteractorMock.loadEventsSuccessCount, 0)
        XCTAssertEqual(eventsInteractorMock.loadEventsFailureCount, 0)
        
        eventsViewMock.presenter?.viewLoaded()
        XCTAssertEqual(eventsInteractorMock.loadEventsCount, 2)
        XCTAssertEqual(eventsInteractorMock.loadEventsSuccessCount, 0)
        XCTAssertEqual(eventsInteractorMock.loadEventsFailureCount, 2)
    }
    
    func testTableReloaded() {
        eventsInteractorMock.loadEventsShouldSucceed = true
        let _ = createSut()
        XCTAssertFalse(eventsViewMock.didReloadTable)
        eventsViewMock.presenter?.viewLoaded()
        XCTAssertTrue(eventsViewMock.didReloadTable)
    }
    
    func testSuccessfulLoadComics() {
        eventsInteractorMock.loadComicsShouldSucceed = true
        let sut = createSut()
        
        eventsViewMock.presenter?.viewLoaded()
        XCTAssertEqual(eventsInteractorMock.loadComicsCount, 0)
        XCTAssertEqual(eventsInteractorMock.loadComicsSuccessCount, 0)
        XCTAssertEqual(eventsInteractorMock.loadComicsFailureCount, 0)
        
        sut.didSelectEventAt(row: 0)
        XCTAssertEqual(eventsInteractorMock.loadComicsCount, 1)
        XCTAssertEqual(eventsInteractorMock.loadComicsSuccessCount, 1)
        XCTAssertEqual(eventsInteractorMock.loadComicsFailureCount, 0)
    }
    
    func testUnsuccessfulLoadComics() {
        eventsInteractorMock.loadComicsShouldSucceed = false
        let sut = createSut()
        eventsViewMock.presenter?.viewLoaded()
        XCTAssertEqual(eventsInteractorMock.loadComicsCount, 0)
        XCTAssertEqual(eventsInteractorMock.loadComicsSuccessCount, 0)
        XCTAssertEqual(eventsInteractorMock.loadComicsFailureCount, 0)
        
        sut.didSelectEventAt(row: 0)
        XCTAssertEqual(eventsInteractorMock.loadComicsCount, 1)
        XCTAssertEqual(eventsInteractorMock.loadComicsSuccessCount, 0)
        XCTAssertEqual(eventsInteractorMock.loadComicsFailureCount, 1)
    }
    
    func testRouterPresent() {
        eventsInteractorMock.loadComicsShouldSucceed = true
        let sut = createSut()
        eventsViewMock.presenter?.viewLoaded()
        XCTAssertFalse(eventsRouterMock.didPresentComics)
        
        sut.didSelectEventAt(row: 0)
        XCTAssertTrue(eventsRouterMock.didPresentComics)
    }
}
