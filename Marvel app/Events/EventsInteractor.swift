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
    func loadEvents(onCompletion completionHandler: @escaping (Result<[Event], Error>) -> ())
    func loadComicsFor(eventId: Int, onCompletion completionHandler: @escaping (Result<[String], Error>) -> ())
}

// MARK: - PresenterToInteractorProtocol
final class EventsInteractor: EventsPresenterToInteractorProtocol {
    weak var presenter: BaseViewProtocol?
    private let eventsRepository: EventsRepositoryProtocol
    
    init(eventsRepository: EventsRepositoryProtocol) {
        self.eventsRepository = eventsRepository
    }
    
    func loadEvents(onCompletion completionHandler: @escaping (Result<[Event], Error>) -> ()) {
        presenter?.showLoader()
        eventsRepository.getEvents { [weak self] result in
            guard let self = self else { return }
            self.presenter?.hideLoader()

            switch result {
            case .success(let events):
                let eventsArray = events.data.results
                completionHandler(.success(eventsArray))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func loadComicsFor(eventId: Int, onCompletion completionHandler: @escaping (Result<[String], Error>) -> ()) {
        presenter?.showLoader()
        eventsRepository.loadComicsFor(id: eventId) { [weak self] result in
            guard let self = self else { return }
            self.presenter?.hideLoader()
            
            switch result {
            case .success(let comics):
                let comicItems = comics.data.results.map { $0.title }
                completionHandler(.success(comicItems))
            case .failure(let error):
                completionHandler(.failure(error))
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
