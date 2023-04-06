//
//  ViewController.swift
//  Marvel app
//
//  Created by Salvador on 3/31/23.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTabs()
    }
    
    func setupTabs() {
        viewControllers = [
            getNavigationController(for: Self.firstTab, title: "Characters", image: .characters),
            getNavigationController(for: Self.secondTab, title: "Events", image: .events)
        ]
    }
}

extension TabBarViewController {
    func getNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
    
    static var firstTab: UIViewController {
        CharactersConfigurator.resolve()
    }
    
    static var secondTab: UIViewController {
        EventsConfigurator.resolve()
    }
}

