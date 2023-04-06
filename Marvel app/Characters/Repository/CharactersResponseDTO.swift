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
