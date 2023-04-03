//
//  
//  EventComicsInteractor.swift
//  Marvel app
//
//  Created by Salvador on 4/2/23.
//
//
import Foundation

protocol EventComicsPresenterToInteractorProtocol: AnyObject {
    var eventItem: Item { get }
}

// MARK: - PresenterToInteractorProtocol
final class EventComicsInteractor: EventComicsPresenterToInteractorProtocol {
    let eventItem: Item
    
    init(eventItem: Item) {
        self.eventItem = eventItem
    }
}

// MARK: - Entity
struct EventComicsEntity: Codable {
}
