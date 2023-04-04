//
//  
//  CharacterComicsConfigurator.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//
//
import Foundation

final class CharacterComicsConfigurator {
    static func injectDependencies(view: CharacterComicsPresenterToViewProtocol,
                                   interactor: CharacterComicsPresenterToInteractorProtocol,
                                   presenter: CharacterComicsPresenter) {
        presenter.interactor = interactor

        view.presenter = presenter
        presenter.viewCharacterComics = view
    }
}
