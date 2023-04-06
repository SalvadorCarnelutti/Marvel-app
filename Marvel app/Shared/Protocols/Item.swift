//
//  Item.swift
//  Marvel app
//
//  Created by Salvador on 4/6/23.
//

import Foundation

protocol Item {
    var imageURL: URL { get }
    var heading: String { get }
    var description: String { get }
}
