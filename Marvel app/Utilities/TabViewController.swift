//
//  TabViewController.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//

import UIKit

class TabViewController: BaseViewController {
    let sessionManager = SessionManager()
    
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
            try sessionManager.logout()
            view.window?.rootViewController = AppDelegate.authViewController
        } catch {
            presentOKAlert(title: "Logout error", message: "Unexpected logout error")
        }
    }
}

class SessionManager {
    static let shared = SessionManager()
    
    init() {}
    
    func logout() throws {
        try AppDelegate.authUI.signOut()
    }
}
