//
//  UITableViewCell.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
    
    static func assertCellFailure() {
        assertionFailure("There was an issue creating the \(self.identifier) cell")
    }
}
