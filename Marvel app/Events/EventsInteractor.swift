//
//  
//  EventsInteractor.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import Foundation
import Alamofire

protocol EventsPresenterToInteractorProtocol: AnyObject {
    var itemsCount: Int { get }
    func loadEvents(onSuccess: @escaping () -> ())
    func loadComicsAt(row: Int, onSuccess: @escaping (Item) -> ())
    func itemAt(row: Int) -> Item
}

// MARK: - PresenterToInteractorProtocol
final class EventsInteractor: EventsPresenterToInteractorProtocol {
    func itemAt(row: Int) -> Item {
        items[row]
    }
    
    var itemsCount: Int {
        return items.count
    }
    
    let session = Session(eventMonitors: [AlamofireLogger()])
    var items = [EventCellItem]()

    
    func loadEvents(onSuccess: @escaping () -> ()) {
        session.request("https://gateway.marvel.com/v1/public/events",
                        parameters: [
                            "apikey":"5b23e88d26cf56958f076f88be9fed9d",
                            "hash" : MD5(string: "1" + "b220d549848ca21eacd776e73db60e6deccfd95f" + "5b23e88d26cf56958f076f88be9fed9d"),
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
                    self?.items = combinedEvents
                    onSuccess()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func loadComicsAt(row: Int, onSuccess: @escaping (Item) -> ()) {
        session.request("https://gateway.marvel.com/v1/public/events/\(items[row].id)/comics",
                        parameters: [
                            "apikey":"5b23e88d26cf56958f076f88be9fed9d",
                            "hash" : MD5(string: "1" + "b220d549848ca21eacd776e73db60e6deccfd95f" + "5b23e88d26cf56958f076f88be9fed9d"),
                            "ts" : "1"
                        ]).validate(statusCode: 200...299)
            .responseDecodable(of: ComicsResponse.self) { [weak self] (response) in
                guard let self = self else { return }
                switch response.result {
                case .success(let events):
                    onSuccess(self.items[row])
                case .failure(let error):
                    print(error)
                }
            }
    }

}

// MARK: - Entity
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
        EventCellItem(id: id, imageURL: thumbnail.imageURL, heading: title, startDate: Date.formatAsDate(start, dateFormat: "yyyy-MM-dd hh:mm:ss"))
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

import CryptoKit

func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: Data(string.utf8))

    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}
