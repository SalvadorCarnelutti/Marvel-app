//
//  
//  CharactersInteractor.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import Alamofire

protocol CharactersPresenterToInteractorProtocol: AnyObject, ItemTableViewProtocol {
    func loadCharacters(onSuccess: @escaping () -> ())
    func loadComicsAt(row: Int, onSuccess: @escaping (CharacterComics) -> ())
}

// MARK: - PresenterToInteractorProtocol
final class CharactersInteractor: CharactersPresenterToInteractorProtocol {
    private let charactersRepository: CharactersRepositoryProtocol
//    let session = Session(eventMonitors: [AlamofireLogger()])
    
    init(charactersRepository: CharactersRepositoryProtocol) {
        self.charactersRepository = charactersRepository
    }
    
    var characterItems = [CharacterCellItem]()
    
    var itemsCount: Int {
        characterItems.count
    }
    
    func itemAt(row: Int) -> Item {
        characterItems[row]
    }
    
    func loadCharacters(onSuccess: @escaping () -> ()) {
        charactersRepository.getCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characterItems = characters.data.results.map { $0.getItem }
                onSuccess()
            case .failure:
                print("Error")
            }
        }
    }
    
    func loadComicsAt(row: Int, onSuccess: @escaping (CharacterComics) -> ()) {
        charactersRepository.loadComicsFor(id: characterItems[row].id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let comics):
                let characterItem = self.characterItems[row]
                let comicItems = comics.data.results.map { $0.title }
                onSuccess(CharacterComics(characterItem: characterItem, comicItems: comicItems))
            case .failure:
                print("Error")
            }
        }
    }
}

// MARK: - Characters Entity

struct CharacterCellItem: Item {
    let id: Int
    var imageURL: URL
    let heading: String
    let description: String
}
