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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil,
                                                            image: UIImage.logout,
                                                            target: self,
                                                            action: #selector(logoutTapped))
    }
    
    @objc private func logoutTapped() {
        do {
            try AppDelegate.singleton.authUI.signOut()
            view.window?.rootViewController = AppDelegate.singleton.authUI.authViewController()
        } catch {
            presentOKAlert(title: "Logout error", message: "Unexpected logout error")
        }
    }
}
