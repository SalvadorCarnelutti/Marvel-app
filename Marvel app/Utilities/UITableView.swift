//
//  UITableView.swift
//  Marvel app
//
//  Created by Salvador on 4/2/23.
//

import UIKit

extension UITableView {
    func register(_ cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
}
