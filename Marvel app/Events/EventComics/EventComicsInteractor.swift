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
    var comicsCount: Int { get }
    func comicAt(row: Int) -> String
}

// MARK: - PresenterToInteractorProtocol
final class EventComicsInteractor: EventComicsPresenterToInteractorProtocol {
    let eventComics: EventComics
    
    init(eventComics: EventComics) {
        self.eventComics = eventComics
    }
    
    var eventItem: Item {
        eventComics.eventItem
    }
    
    var comicsCount: Int {
        eventComics.comicItems.count
    }
    
    func comicAt(row: Int) -> String {
        eventComics.comicItems[row]
    }
}

// MARK: - Entity
struct EventComics {
    let eventItem : Item
    let comicItems: [String]
}
