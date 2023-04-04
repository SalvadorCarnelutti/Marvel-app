//
//  
//  CharacterComicsPresenter.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//
//

import UIKit

protocol CharacterComicsViewToPresenterProtocol: UIViewController, ComicsTableViewProtocol {
    var characterItem: Item { get }
}

final class CharacterComicsPresenter: UIViewController {
    var viewCharacterComics: CharacterComicsPresenterToViewProtocol!
    var interactor: CharacterComicsPresenterToInteractorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCharacterComics.loadView()
    }
    
    override func loadView() {
        super.loadView()
        title = interactor.characterName
        view = viewCharacterComics
    }
}

// MARK: - ViewToPresenterProtocol
extension CharacterComicsPresenter: CharacterComicsViewToPresenterProtocol {
    var characterItem: Item {
        interactor.characterItem
    }
    
    var comicsCount: Int {
        interactor.comicsCount
    }
    
    func comicAt(row: Int) -> String {
        interactor.comicAt(row: row)
    }
}
