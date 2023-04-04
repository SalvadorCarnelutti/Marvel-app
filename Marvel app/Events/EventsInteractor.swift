//
//  
//  EventsInteractor.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import Alamofire

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
    let session = Session(eventMonitors: [AlamofireLogger()])
    var eventItems = [EventCellItem]()
    
    var itemsCount: Int {
        eventItems.count
    }
    
    func itemAt(row: Int) -> Item {
        eventItems[row]
    }
    
    func loadEvents(onSuccess: @escaping () -> ()) {
        session.request("https://gateway.marvel.com/v1/public/events",
                        parameters: [
                            "apikey": CryptoHelper.apiKey,
                            "hash" : CryptoHelper.hash,
                            "ts" : "1",
                            "limit" : "25",
                            "orderBy" : "-startDate"
                        ]).validate(statusCode: 200...299)
            .responseDecodable(of: EventResponse.self) { [weak self] (response) in
                switch response.result {
                case .success(let events):
                    let eventsArray = events.data.results
                    let dateSortedEvents = eventsArray.filter { $0.start != nil }.map { $0.getItem }.sorted { $0.startDate! > $1.startDate! }
                    let datelessEvents = eventsArray.filter { $0.start == nil }.map { $0.getItem }
                    let combinedEvents = dateSortedEvents + datelessEvents
                    self?.eventItems = combinedEvents
                    onSuccess()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func loadComicsAt(row: Int, onSuccess: @escaping (EventComics) -> ()) {
        session.request("https://gateway.marvel.com/v1/public/events/\(eventItems[row].id)/comics",
                        parameters: [
                            "apikey": CryptoHelper.publicKey,
                            "hash" : CryptoHelper.hash,
                            "ts" : "1"
                        ]).validate(statusCode: 200...299)
            .responseDecodable(of: ComicsResponse.self) { [weak self] (response) in
                guard let self = self else { return }
                switch response.result {
                case .success(let events):
                    let eventItem = self.eventItems[row]
                    let comicItems = events.data.results.map { $0.title }
                    onSuccess(EventComics(eventItem: eventItem, comicItems: comicItems))
                case .failure(let error):
                    print(error)
                }
            }
    }
}

// MARK: - Events Entity
struct EventResponse: Codable {
    let data: Events
}

struct Events: Codable {
    let results: [Event]
}

struct Event: Codable {
    let id: Int
    let thumbnail: Image
    let title: String
    let start: String?
}

struct Image: Codable {
    let path: String
    let fileExtension: String
    
    var imageURL: URL {
        return URL(string: path.https + "." + fileExtension)!
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}

extension Event {
    var getItem: EventCellItem {
        EventCellItem(id: id,
                      imageURL: thumbnail.imageURL,
                      heading: title,
                      startDate: Date.formatAsDate(start, dateFormat: "yyyy-MM-dd hh:mm:ss"))
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

// MARK: - Comics Entity
struct ComicsResponse: Codable {
    let data: Comics
}

struct Comics: Codable {
    let results: [Comic]
}

struct Comic: Codable {
    let title: String
}
