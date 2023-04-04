//
//  CharactersRepository.swift
//  Marvel app
//
//  Created by Salvador on 4/4/23.
//

import Foundation

protocol CharactersRepositoryProtocol {
    func getCharacters(onCompletion completionHandler: @escaping (Result<CharactersResponse, Error>) -> Void)
    func loadComicsFor(id: Int, onCompletion completionHandler: @escaping (Result<ComicsResponse, Error>) -> Void)
}

class CharactersRepository: CharactersRepositoryProtocol {
    func getCharacters(onCompletion completionHandler: @escaping (Result<CharactersResponse, Error>) -> Void) {
        let charactersUrl: String = "https://gateway.marvel.com/v1/public/characters"
        let params = [
            "apikey": CryptoHelper.apiKey,
            "hash" : CryptoHelper.hash,
            "ts" : "1"
        ]
        
        RestClient<CharactersResponse>(httpManager: HTTPManager()).queryGet(charactersUrl, params: params) { result in
            switch result {
            case .success(let charactersDTO):
                completionHandler(.success(charactersDTO))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func loadComicsFor(id: Int, onCompletion completionHandler: @escaping (Result<ComicsResponse, Error>) -> Void) {
        let comicsUrl: String = "https://gateway.marvel.com/v1/public/characters/\(id)/comics"
        let params = [
            "apikey": CryptoHelper.publicKey,
            "hash" : CryptoHelper.hash,
            "ts" : "1"
        ]
        
        RestClient<ComicsResponse>(httpManager: HTTPManager()).queryGet(comicsUrl, params: params) { result in
            switch result {
            case .success(let comicsDTO):
                completionHandler(.success(comicsDTO))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
