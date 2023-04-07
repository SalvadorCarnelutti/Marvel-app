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
                                   presenter: CharactersPresenter,
                                   router: CharactersPresenterToRouterProtocol) {
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        view.presenter = presenter
        presenter.viewCharacters = view
        
        router.viewController = presenter
        presenter.router = router
    }
    
    static func resolve() -> CharactersPresenter {
        let charactersPresenter = CharactersPresenter()
        let charactersView = CharactersView()
        let charactersInteractor = CharactersInteractor(charactersRepository: CharactersRepository())
        let charactersRouter = CharactersRouter()
        
        Self.injectDependencies(view: charactersView,
                                interactor: charactersInteractor,
                                presenter: charactersPresenter,
                                router: charactersRouter)
        
        return charactersPresenter
    }
}
