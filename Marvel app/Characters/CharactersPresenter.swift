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
    func loadCharacters(onSuccess: @escaping ([IndexPath]) -> ())
    func loadComicsAt(row: Int)
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
}

// MARK: - ViewToPresenterProtocol
extension CharactersPresenter: CharactersViewToPresenterProtocol {
    var itemsCount: Int {
        characterItems.count
    }
    
    func loadCharacters(onSuccess: @escaping ([IndexPath]) -> ()) {
        interactor.loadCharacters { [weak self] characters in
            guard let self = self else { return }
            
            let newIndexPaths = self.newIndexPaths(newItemsCount: characters.count)
            self.characterItems += characters.map { $0.getItem }
            onSuccess(newIndexPaths)
        }
    }
    
    func loadComicsAt(row: Int) {
        interactor.loadComicsFor(characterId: characterItems[row].id) { [weak self] comicItems in
            guard let self = self else { return }
            self.router.pushComics(with: CharacterComics(characterItem: self.itemAt(row: row), comicItems: comicItems))
        }
    }
    
    func itemAt(row: Int) -> Item {
        characterItems[row]
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
            return "Bio unavailable"
        }
        
        return description
    }
    
    var getItem: CharacterCellItem {
        CharacterCellItem(id: id, imageURL: thumbnail.imageURL, heading: name, description: characterDescription)
    }
}
