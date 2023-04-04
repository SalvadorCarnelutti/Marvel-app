//
//  
//  EventComicsInteractor.swift
//  Marvel app
//
//  Created by Salvador on 4/2/23.
//
//
import Foundation

protocol ComicsTableViewProtocol: AnyObject {
    var comicsCount: Int { get }
    func comicAt(row: Int) -> String
}

protocol EventComicsPresenterToInteractorProtocol: ComicsTableViewProtocol {
    var eventItem: Item { get }
    var isComicsEmpty: Bool { get }
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
    
    var isComicsEmpty: Bool {
        eventComics.comicItems.isEmpty
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
