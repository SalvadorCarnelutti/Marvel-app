//
//  ItemTableViewProtocol.swift
//  Marvel app
//
//  Created by Salvador on 4/6/23.
//

import Foundation

protocol ItemTableViewProtocol: AnyObject {
    var itemsCount: Int { get }
    func itemAt(row: Int) -> Item
}
