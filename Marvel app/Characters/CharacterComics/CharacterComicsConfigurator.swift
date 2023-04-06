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
    private static func injectDependencies(view: CharacterComicsPresenterToViewProtocol,
                                           presenter: CharacterComicsPresenter) {
        view.presenter = presenter
        presenter.viewCharacterComics = view
    }
    
    static func resolve(characterComics: CharacterComics) -> CharacterComicsPresenter {
        let characterComicsPresenter = CharacterComicsPresenter(characterComics: characterComics)
        let characterComicsView = CharacterComicsView()
        Self.injectDependencies(view: characterComicsView,
                                presenter: characterComicsPresenter)
        
        return characterComicsPresenter
    }
}
