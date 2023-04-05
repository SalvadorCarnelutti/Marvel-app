//
//  TabViewController.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//

import UIKit

class TabViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Marvel Challenge"
        let image = UIImage.logout.withTintColor(.black, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil,
                                                            image: image,
                                                            target: self,
                                                            action: #selector(logoutTapped))
    }
    
    @objc func logoutTapped() {
        // TBD
    }
}
