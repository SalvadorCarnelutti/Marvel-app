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
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupTabs()
    }
    
    func setupTabs() {
        viewControllers = [
            Self.getNavigationController(for: Self.firstTab, title: "Characters", image: .characters),
            Self.getNavigationController(for: Self.secondTab, title: "Events", image: .events)
        ]
    }
}

extension TabBarViewController {
    static func getNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
    static var firstTab: UIViewController {
        let charactersPresenter = CharactersPresenter()
        let charactersView = CharactersView()
        let charactersInteractor = CharactersInteractor()
        let charactersRouter = CharactersRouter()
        
        CharactersConfigurator.injectDependencies(view: charactersView,
                                                  interactor: charactersInteractor,
                                                  presenter: charactersPresenter, router: charactersRouter)
        return charactersPresenter
    }
    
    static var secondTab: UIViewController {
        let eventsPresenter = EventsPresenter()
        let eventsView = EventsView()
        let eventsInteractor = EventsInteractor()
        let eventRouter = EventsRouter()
        
        EventsConfigurator.injectDependencies(view: eventsView,
                                              interactor: eventsInteractor,
                                              presenter: eventsPresenter,
                                              router: eventRouter)
        return eventsPresenter
    }
}

