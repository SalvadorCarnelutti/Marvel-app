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
    func didSelectCharacterAt(row: Int)
    func viewLoaded()
    func isPrefetching()
}

final class CharactersPresenter: TabViewController {
    private var characterItems = [CharacterCellItem]()
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
    
    // This must be run before updating characterItems on each new character batch pull
    private func newIndexPaths(newItemsCount: Int) -> [IndexPath] {
        let startIndex = itemsCount
        let endIndex = startIndex + newItemsCount
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    private func loadCharacters() {
        interactor.loadCharacters { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let characters):
                let newIndexPaths = self.newIndexPaths(newItemsCount: characters.count)
                self.characterItems += characters.map { $0.getItem }
                // We are inserting new rows, not reloading them
                self.viewCharacters.insertRows(at: newIndexPaths)
            case .failure(let error):
                self.presentOKAlert(title: "alert_character_title".localized, message: error.localizedDescription)
            }
        }
    }
}

// MARK: - ViewToPresenterProtocol
extension CharactersPresenter: CharactersViewToPresenterProtocol {
    var itemsCount: Int {
        characterItems.count
    }
    
    func didSelectCharacterAt(row: Int) {
        interactor.loadComicsFor(characterId: characterItems[row].id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let comicItems):
                self.router.pushComics(with: CharacterComics(characterItem: self.itemAt(row: row), comicItems: comicItems))
            case .failure(let error):
                self.presentOKAlert(title: "alert_comics_title".localized, message: error.localizedDescription)
            }
        }
    }
    
    func itemAt(row: Int) -> Item {
        characterItems[row]
    }
    
    func viewLoaded() {
        loadCharacters()
    }
    
    func isPrefetching() {
        loadCharacters()
    }
}

struct CharacterCellItem: Item {
    let id: Int
    var imageURL: URL
    let heading: String
    let description: String
}

extension Character {
    var characterDescription: String {
        guard let description = description, !description.isEmpty else {
            return "character_no_bio".localized
        }
        
        return description
    }
    
    var getItem: CharacterCellItem {
        CharacterCellItem(id: id, imageURL: thumbnail.imageURL, heading: name, description: characterDescription)
    }
}
