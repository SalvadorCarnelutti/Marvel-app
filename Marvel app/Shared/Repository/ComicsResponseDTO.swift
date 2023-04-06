//
//  ComicsResponseDTO.swift
//  Marvel app
//
//  Created by Salvador on 4/6/23.
//

import Foundation

struct ComicsResponse: Codable {
    let data: Comics
}

struct Comics: Codable {
    let results: [Comic]
}

struct Comic: Codable {
    let title: String
}
