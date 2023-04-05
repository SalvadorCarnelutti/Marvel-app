//
//  
//  EventsConfigurator.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import Foundation

final class EventsConfigurator {
    static func injectDependencies(view: EventsPresenterToViewProtocol,
                                   interactor: EventsPresenterToInteractorProtocol,
                                   presenter: EventsPresenter,
                                   router: EventsPresenterToRouterProtocol) {
        presenter.interactor = interactor
        interactor.viewController = presenter

        view.presenter = presenter
        presenter.viewEvents = view
        
        router.viewController = presenter
        presenter.router = router
    }
}
