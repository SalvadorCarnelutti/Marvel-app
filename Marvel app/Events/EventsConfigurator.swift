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
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        view.presenter = presenter
        presenter.viewEvents = view
        
        router.viewController = presenter
        presenter.router = router
    }
    
    static func resolve() -> EventsPresenter {
        let eventsPresenter = EventsPresenter()
        let eventsView = EventsView()
        let eventsInteractor = EventsInteractor(eventsRepository: EventsRepository())
        let eventRouter = EventsRouter()
        
        Self.injectDependencies(view: eventsView,
                                interactor: eventsInteractor,
                                presenter: eventsPresenter,
                                router: eventRouter)
        
        return eventsPresenter

    }
}
