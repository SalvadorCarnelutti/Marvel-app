//
//  
//  CharactersPresenter.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//

import UIKit

protocol CharactersViewToPresenterProtocol: UIViewController, ItemTableViewProtocol {
    func loadCharacters(onSuccess: @escaping () -> ())
    func loadComicsAt(row: Int)
}

final class CharactersPresenter: TabViewController {
    var viewCharacters: CharactersPresenterToViewProtocol!
    var interactor: CharactersPresenterToInteractorProtocol!
    var router: CharactersPresenterToRouterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCharacters.loadView()
    }
    
    override func loadView() {
        super.loadView()
        view = viewCharacters
    }
}

// MARK: - ViewToPresenterProtocol
extension CharactersPresenter: CharactersViewToPresenterProtocol {
    var itemsCount: Int {
        interactor.itemsCount
    }
    
    func loadCharacters(onSuccess: @escaping () -> ()) {
        interactor.loadCharacters(onSuccess: onSuccess)
    }
    
    func loadComicsAt(row: Int) {
        interactor.loadComicsAt(row: row, onSuccess: router.pushComics)
    }
    
    func itemAt(row: Int) -> Item {
        interactor.itemAt(row: row)
    }
}
