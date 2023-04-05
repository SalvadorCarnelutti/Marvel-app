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
    var isComicsEmpty: Bool { get }
}

final class CharacterComicsPresenter: BaseViewController {
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
        setupCustomBackButton()
    }
    
    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupCustomBackButton() {
        let backImage = UIImage.xBack.withTintColor(.white, renderingMode: .alwaysOriginal)
        let backBarButton = UIBarButtonItem(image: backImage,
                                            style: .plain,
                                            target: self,
                                            action: #selector(popViewController))
        
        navigationItem.setLeftBarButton(backBarButton, animated: true)
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
    
    var isComicsEmpty: Bool {
        interactor.isComicsEmpty
    }
    
    func comicAt(row: Int) -> String {
        interactor.comicAt(row: row)
    }
}
