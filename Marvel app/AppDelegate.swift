//
//  AppDelegate.swift
//  Marvel app
//
//  Created by Salvador on 3/31/23.
//

import UIKit
import FirebaseCore
import FirebaseEmailAuthUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var authUI = FUIAuth.defaultAuthUI()!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupFirebase()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func setupFirebase() {
        FirebaseApp.configure()
        let authProviders: [FUIAuthProvider] = [FUIEmailAuth()]
        authUI.providers = authProviders
    }
}

extension AppDelegate: FUIAuthDelegate {
    static var singleton: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    static var authUI: FUIAuth {
        singleton.authUI
    }
    
    static var authViewController: UINavigationController {
        authUI.authViewController()
    }
    
    static func configureAuthUIDelegate(delegate: FUIAuthDelegate) {
        authUI.delegate = delegate
    }
}
