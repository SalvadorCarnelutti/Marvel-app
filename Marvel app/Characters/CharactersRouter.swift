//
//  CharactersRouter.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//

import UIKit

protocol CharactersPresenterToRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func pushComics(with characterComics: CharacterComics)
}

class CharactersRouter: CharactersPresenterToRouterProtocol {
    // MARK: - Properties
    weak var viewController: UIViewController?
    
    func pushComics(with characterComics: CharacterComics) {
        let eventComicsPresenter = CharacterComicsPresenter()
        let eventComicsView = CharacterComicsView()
        let eventComicsInteractor = CharacterComicsInteractor(characterComics: characterComics)
        CharacterComicsConfigurator.injectDependencies(view: eventComicsView,
                                                       interactor: eventComicsInteractor,
                                                       presenter: eventComicsPresenter)
        
        eventComicsPresenter.modalPresentationStyle = .popover
        viewController?.navigationController?.pushViewController(eventComicsPresenter, animated: true)
    }
}
