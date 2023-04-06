//
//  ComicsTableViewProtocol.swift
//  Marvel app
//
//  Created by Salvador on 4/6/23.
//

import Foundation

protocol ComicsTableViewProtocol: AnyObject {
    var comicsCount: Int { get }
    func comicAt(row: Int) -> String
}
