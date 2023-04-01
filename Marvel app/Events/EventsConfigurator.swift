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
                                   presenter: EventsPresenter) {
        presenter.interactor = interactor

        view.presenter = presenter
        presenter.viewEvents = view
    }
}
