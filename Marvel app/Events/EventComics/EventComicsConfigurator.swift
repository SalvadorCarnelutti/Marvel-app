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
    private static func injectDependencies(view: EventComicsPresenterToViewProtocol,
                                           presenter: EventComicsPresenter) {
        view.presenter = presenter
        presenter.viewEventComics = view
    }
    
    static func resolve(eventComics: EventComics) -> EventComicsPresenter {
        let eventComicsPresenter = EventComicsPresenter(eventComics: eventComics)
        let eventComicsView = EventComicsView()
        Self.injectDependencies(view: eventComicsView,
                                presenter: eventComicsPresenter)
        
        return eventComicsPresenter
    }

}
