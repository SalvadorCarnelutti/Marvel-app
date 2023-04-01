//
//  
//  CharactersConfigurator.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import Foundation

final class CharactersConfigurator {
    static func injectDependencies(view: CharactersPresenterToViewProtocol,
                                   interactor: CharactersPresenterToInteractorProtocol,
                                   presenter: CharactersPresenter) {
        presenter.interactor = interactor

        view.presenter = presenter
        presenter.viewCharacters = view
    }
}
