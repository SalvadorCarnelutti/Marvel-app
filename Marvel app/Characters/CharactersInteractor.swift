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
    let session = Session(eventMonitors: [AlamofireLogger()])
    var characterItems = [CharacterCellItem]()
    
    var itemsCount: Int {
        characterItems.count
    }
    
    func itemAt(row: Int) -> Item {
        characterItems[row]
    }
    
    func loadCharacters(onSuccess: @escaping () -> ()) {
        session.request("https://gateway.marvel.com/v1/public/characters",
                        parameters: [
                            "apikey": CryptoHelper.apiKey,
                            "hash" : CryptoHelper.hash,
                            "ts" : "1",
                            "limit" : "25"
                        ]).validate(statusCode: 200...299)
            .responseDecodable(of: CharacterResponse.self) { [weak self] (response) in
                switch response.result {
                case .success(let events):
                    self?.characterItems = events.data.results.map { $0.getItem }
                    onSuccess()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func loadComicsAt(row: Int, onSuccess: @escaping (CharacterComics) -> ()) {
        session.request("https://gateway.marvel.com/v1/public/characters/\(characterItems[row].id)/comics",
                        parameters: [
                            "apikey": CryptoHelper.publicKey,
                            "hash" : CryptoHelper.hash,
                            "ts" : "1"
                        ]).validate(statusCode: 200...299)
            .responseDecodable(of: ComicsResponse.self) { [weak self] (response) in
                guard let self = self else { return }
                switch response.result {
                case .success(let events):
                    let characterItem = self.characterItems[row]
                    let comicItems = events.data.results.map { $0.title }
                    onSuccess(CharacterComics(characterItem: characterItem, comicItems: comicItems))
                case .failure(let error):
                    print(error)
                }
            }
    }
}

// MARK: - Characters Entity
struct CharacterResponse: Codable {
    let data: Characters
}

struct Characters: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let thumbnail: Image
    let name: String
    let description: String?
}

extension Character {
    var getItem: CharacterCellItem {
        CharacterCellItem(id: id, imageURL: thumbnail.imageURL, heading: name, description: description ?? "")
    }
}

struct CharacterCellItem: Item {
    let id: Int
    var imageURL: URL
    let heading: String
    let description: String
}
