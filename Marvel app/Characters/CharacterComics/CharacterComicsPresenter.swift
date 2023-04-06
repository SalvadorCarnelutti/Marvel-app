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
    func viewLoaded()
}

final class CharacterComicsPresenter: BaseViewController {
    private let characterComics: CharacterComics
    var viewCharacterComics: CharacterComicsPresenterToViewProtocol!
    
    init(characterComics: CharacterComics) {
        self.characterComics = characterComics
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCharacterComics.loadView()
    }
    
    override func loadView() {
        super.loadView()
        title = characterComics.characterItem.heading
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
        characterComics.characterItem
    }
    
    var comicsCount: Int {
        characterComics.comicItems.count
    }
    
    func comicAt(row: Int) -> String {
        characterComics.comicItems[row]
    }
    
    func viewLoaded() {
        if characterComics.comicItems.isEmpty {
            viewCharacterComics.configureAsEmpty()
        } else {
            viewCharacterComics.configureTableView()
        }
    }
}

struct CharacterComics {
    let characterItem: Item
    let comicItems: [String]
}
