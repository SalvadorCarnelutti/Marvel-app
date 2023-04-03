//
//  EventsRouter.swift
//  Marvel app
//
//  Created by Salvador on 4/2/23.
//

import UIKit

protocol EventsPresenterToRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    // Need to define item parameter
    func presentComics(with eventItem: Item)
}

class EventsRouter: EventsPresenterToRouterProtocol {
    // MARK: - Properties
    weak var viewController: UIViewController?

    
    func presentComics(with eventItem: Item) {
        let eventComicsPresenter = EventComicsPresenter()
        let eventComicsView = EventComicsView()
        let eventComicsInteractor = EventComicsInteractor(eventItem: eventItem)
        EventComicsConfigurator.injectDependencies(view: eventComicsView,
                                                   interactor: eventComicsInteractor,
                                                   presenter: eventComicsPresenter)
        
        eventComicsPresenter.modalPresentationStyle = .popover
        viewController?.navigationController?.present(eventComicsPresenter, animated: true)
    }
}
