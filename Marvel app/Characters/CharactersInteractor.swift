//
//  
//  CharactersInteractor.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import Foundation

protocol CharactersPresenterToInteractorProtocol: AnyObject {
    var presenter: BaseViewProtocol? { get set }
    func loadCharacters(onCompletion completionHandler: @escaping (Result<[Character], Error>) -> ())
    func loadComicsFor(characterId: Int, onCompletion completionHandler: @escaping (Result<[String], Error>) -> ())
}

// MARK: - PresenterToInteractorProtocol
final class CharactersInteractor: CharactersPresenterToInteractorProtocol {
    weak var presenter: BaseViewProtocol?
    private let charactersRepository: CharactersRepositoryProtocol
    private let pullRate: Int
    private var charactersCount = 0
    
    // Keep track if there are more pages to pull from and if a fetch is already in process
    private var isThereMore = true
    private var isFetchInProgress = false
    
    init(charactersRepository: CharactersRepositoryProtocol, pullRate: Int = 15) {
        self.charactersRepository = charactersRepository
        self.pullRate = pullRate
    }
    
    func loadCharacters(onCompletion completionHandler: @escaping (Result<[Character], Error>) -> ()) {
        guard isThereMore, !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        presenter?.showLoader()
        charactersRepository.getCharacters(limit: pullRate, offset: charactersCount) { [weak self] result in
            guard let self = self else { return }
            self.presenter?.hideLoader()
            self.isFetchInProgress = false
            
            switch result {
            case .success(let charactersResponse):
                let characters = charactersResponse.data.results
                self.charactersCount += characters.count
                
                // Check if we have reached the end of pullable items
                self.isThereMore = self.charactersCount < charactersResponse.data.total
                
                completionHandler(.success(characters))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func loadComicsFor(characterId: Int, onCompletion completionHandler: @escaping (Result<[String], Error>) -> ()) {
        presenter?.showLoader()
        charactersRepository.loadComicsFor(id: characterId) { [weak self] result in
            guard let self = self else { return }
            self.presenter?.hideLoader()
            
            switch result {
            case .success(let comicsResponse):
                let comicItems = comicsResponse.data.results.map { $0.title }
                completionHandler(.success(comicItems))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
