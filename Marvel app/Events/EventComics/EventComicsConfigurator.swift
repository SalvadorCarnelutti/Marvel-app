//
//  
//  EventComicsConfigurator.swift
//  Marvel app
//
//  Created by Salvador on 4/2/23.
//
//
import Foundation

final class EventComicsConfigurator {
    static func injectDependencies(view: EventComicsPresenterToViewProtocol,
                                   interactor: EventComicsPresenterToInteractorProtocol,
                                   presenter: EventComicsPresenter) {
        presenter.interactor = interactor

        view.presenter = presenter
        presenter.viewEventComics = view
    }
}
