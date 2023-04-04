//
//  EventsResponseDTO.swift
//  Marvel app
//
//  Created by Salvador on 4/4/23.
//
import Foundation

struct EventsResponse: Codable {
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
