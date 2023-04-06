//
//  EventsRouter.swift
//  Marvel app
//
//  Created by Salvador on 4/2/23.
//

import UIKit

protocol EventsPresenterToRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func presentComics(with eventComics: EventComics)
}

class EventsRouter: EventsPresenterToRouterProtocol {
    // MARK: - Properties
    weak var viewController: UIViewController?
    
    func presentComics(with eventComics: EventComics) {
        let eventComicsPresenter = EventComicsConfigurator.resolve(eventComics: eventComics)
        eventComicsPresenter.modalPresentationStyle = .popover
        viewController?.navigationController?.present(eventComicsPresenter, animated: true)
    }
}
