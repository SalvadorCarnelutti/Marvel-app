//
//  
//  CharactersPresenter.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//

import UIKit

protocol CharactersViewToPresenterProtocol: UIViewController {
}

final class CharactersPresenter: TabViewController {
    var viewCharacters: CharactersPresenterToViewProtocol!
    var interactor: CharactersPresenterToInteractorProtocol!
    
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
}
