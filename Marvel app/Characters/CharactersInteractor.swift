//
//  
//  CharactersInteractor.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import Foundation

protocol CharactersPresenterToInteractorProtocol: AnyObject, ItemTableViewProtocol {
    var viewController: BaseViewProtocol? { get set }
    func loadCharacters(onSuccess: @escaping ([IndexPath]) -> ())
    func loadComicsAt(row: Int, onSuccess: @escaping (CharacterComics) -> ())
}

// MARK: - PresenterToInteractorProtocol
final class CharactersInteractor: CharactersPresenterToInteractorProtocol {
    weak var viewController: BaseViewProtocol?
    private let charactersRepository: CharactersRepositoryProtocol
    private let pullRate: Int
    private var characterItems = [CharacterCellItem]()
    
    // Keep track if there are more pages to pull from and if a fetch is already in process
    var isThereMore = true
    var isFetchInProgress = false
    
    init(charactersRepository: CharactersRepositoryProtocol, pullRate: Int = 15) {
        self.charactersRepository = charactersRepository
        self.pullRate = pullRate
    }
    
    var itemsCount: Int {
        characterItems.count
    }
    
    func itemAt(row: Int) -> Item {
        characterItems[row]
    }
    
    func loadCharacters(onSuccess: @escaping ([IndexPath]) -> ()) {
        guard isThereMore, !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        viewController?.showLoader()
        charactersRepository.getCharacters(limit: pullRate, offset: itemsCount) { [weak self] result in
            guard let self = self else { return }
            self.viewController?.hideLoader()
            self.isFetchInProgress = false
            
            switch result {
            case .success(let charactersResponse):
                let characters = charactersResponse.data.results
                let newIndexPaths = self.newIndexPaths(newItemsCount: characters.count)
                self.characterItems += characters.map { $0.getItem }
                
                // Check if we have reached the end of pullable items
                self.isThereMore = self.itemsCount < charactersResponse.data.total
                
                DispatchQueue.main.async {
                    onSuccess(newIndexPaths)
                }
            case .failure:
                self.viewController?.presentOKAlert(title: "Characters loading error", message: "Unexpected loading error")
            }
        }
    }
    
    func loadComicsAt(row: Int, onSuccess: @escaping (CharacterComics) -> ()) {
        viewController?.showLoader()
        charactersRepository.loadComicsFor(id: characterItems[row].id) { [weak self] result in
            guard let self = self else { return }
            self.viewController?.hideLoader()
            
            switch result {
            case .success(let comicsResponse):
                let characterItem = self.characterItems[row]
                let comicItems = comicsResponse.data.results.map { $0.title }
                onSuccess(CharacterComics(characterItem: characterItem, comicItems: comicItems))
            case .failure:
                self.viewController?.presentOKAlert(title: "Comics loading error", message: "Unexpected loading error")
            }
        }
    }
    
    // This must be run before updating characterItems on each new character batch pull
    private func newIndexPaths(newItemsCount: Int) -> [IndexPath] {
        let startIndex = itemsCount
        let endIndex = startIndex + newItemsCount
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

struct CharacterCellItem: Item {
    let id: Int
    var imageURL: URL
    let heading: String
    let description: String
}
