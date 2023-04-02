//
//  UITableViewCell.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//

import UIKit

protocol Item {
    var heading: String { get }
    var description: String { get }
}

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}
