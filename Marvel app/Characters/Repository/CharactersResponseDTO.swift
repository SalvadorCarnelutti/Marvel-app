//
//  CharactersResponseDTO.swift
//  Marvel app
//
//  Created by Salvador on 4/4/23.
//

import Foundation

struct CharactersResponse: Codable {
    let data: Characters
}

struct Characters: Codable {
    let total: Int
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let thumbnail: Image
    let name: String
    let description: String?
}

extension Character {
    var characterDescription: String {
        guard let description = description, !description.isEmpty else {
            return "Bio unavailable"
        }
        
        return description
    }
    
    var getItem: CharacterCellItem {
        CharacterCellItem(id: id, imageURL: thumbnail.imageURL, heading: name, description: characterDescription)
    }
}

struct ComicsResponse: Codable {
    let data: Comics
}

struct Comics: Codable {
    let results: [Comic]
}

struct Comic: Codable {
    let title: String
}
