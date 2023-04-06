//
//  
//  EventsInteractor.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import Foundation

protocol EventsPresenterToInteractorProtocol: AnyObject {
    var presenter: BaseViewProtocol? { get set }
    func loadEvents(onSuccess: @escaping ([Event]) -> ())
    func loadComicsFor(eventId: Int, onSuccess: @escaping ([String]) -> ())
}

// MARK: - PresenterToInteractorProtocol
final class EventsInteractor: EventsPresenterToInteractorProtocol {
    weak var presenter: BaseViewProtocol?
    private let eventsRepository: EventsRepositoryProtocol
    
    init(eventsRepository: EventsRepositoryProtocol) {
        self.eventsRepository = eventsRepository
    }
    
    func loadEvents(onSuccess: @escaping ([Event]) -> ()) {
        presenter?.showLoader()
        eventsRepository.getEvents { [weak self] result in
            guard let self = self else { return }
            self.presenter?.hideLoader()

            switch result {
            case .success(let events):
                let eventsArray = events.data.results
                onSuccess(eventsArray)
            case .failure:
                self.presenter?.presentOKAlert(title: "Events loading error", message: "Unexpected loading error")
            }
        }
    }
    
    func loadComicsFor(eventId: Int, onSuccess: @escaping ([String]) -> ()) {
        presenter?.showLoader()
        eventsRepository.loadComicsFor(id: eventId) { [weak self] result in
            guard let self = self else { return }
            self.presenter?.hideLoader()
            
            switch result {
            case .success(let comics):
                let comicItems = comics.data.results.map { $0.title }
                onSuccess(comicItems)
            case .failure:
                self.presenter?.presentOKAlert(title: "Comics loading error", message: "Unexpected loading error")
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
