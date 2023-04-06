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
        let characterComicsPresenter = CharacterComicsConfigurator.resolve(characterComics: characterComics)
        characterComicsPresenter.modalPresentationStyle = .popover
        viewController?.navigationController?.pushViewController(characterComicsPresenter, animated: true)
    }
}
