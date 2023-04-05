//
//  
//  EventsInteractor.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import Foundation

protocol ItemTableViewProtocol: AnyObject {
    var itemsCount: Int { get }
    func itemAt(row: Int) -> Item
}

protocol EventsPresenterToInteractorProtocol: ItemTableViewProtocol {
    func loadEvents(onSuccess: @escaping () -> ())
    func loadComicsAt(row: Int, onSuccess: @escaping (EventComics) -> ())
}

// MARK: - PresenterToInteractorProtocol
final class EventsInteractor: EventsPresenterToInteractorProtocol {
    private let eventsRepository: EventsRepositoryProtocol
    var eventItems = [EventCellItem]()
    
    init(eventsRepository: EventsRepositoryProtocol) {
        self.eventsRepository = eventsRepository
    }
    
    var itemsCount: Int {
        eventItems.count
    }
    
    func itemAt(row: Int) -> Item {
        eventItems[row]
    }
    
    func loadEvents(onSuccess: @escaping () -> ()) {
        eventsRepository.getEvents { [weak self] result in
            switch result {
            case .success(let events):
                let eventsArray = events.data.results
                let dateSortedEvents = eventsArray.filter { $0.start != nil }.map { $0.getItem }.sorted { $0.startDate! > $1.startDate! }
                let datelessEvents = eventsArray.filter { $0.start == nil }.map { $0.getItem }
                let combinedEvents = dateSortedEvents + datelessEvents
                self?.eventItems = combinedEvents
                onSuccess()
            case .failure:
                print("Error")
            }
        }
    }
    
    func loadComicsAt(row: Int, onSuccess: @escaping (EventComics) -> ()) {
        eventsRepository.loadComicsFor(id: eventItems[row].id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let comics):
                let eventItem = self.eventItems[row]
                let comicItems = comics.data.results.map { $0.title }
                onSuccess(EventComics(eventItem: eventItem, comicItems: comicItems))
            case .failure:
                print("Error")
            }
        }
    }
}

struct EventCellItem: Item {
    let id: Int
    var imageURL: URL
    let heading: String
    let startDate: Date?
    
    var description: String {
        startDate?.formatAsString(dateFormat: "MMM d, yyyy") ?? "Unknown date"
    }
}
