//
//  EventsRepository.swift
//  Marvel app
//
//  Created by Salvador on 4/4/23.
//

protocol EventsRepositoryProtocol {
    func getEvents(onCompletion completionHandler: @escaping (Result<EventsResponse, Error>) -> Void)
    func loadComicsFor(id: Int, onCompletion completionHandler: @escaping (Result<ComicsResponse, Error>) -> Void)
}

class EventsRepository: EventsRepositoryProtocol {
    func getEvents(onCompletion completionHandler: @escaping (Result<EventsResponse, Error>) -> Void) {
        let eventsUrl: String = "https://gateway.marvel.com/v1/public/events"
        let params = [
            "apikey": CryptoHelper.apiKey,
            "hash" : CryptoHelper.hash,
            "ts" : "1",
            "limit" : "25",
            "orderBy" : "-startDate"
        ]
        
        RestClient<EventsResponse>(httpManager: HTTPManager()).queryGet(eventsUrl, params: params) { result in
            switch result {
            case .success(let eventsDTO):
                completionHandler(.success(eventsDTO))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func loadComicsFor(id: Int, onCompletion completionHandler: @escaping (Result<ComicsResponse, Error>) -> Void) {
        let comicsUrl: String = "https://gateway.marvel.com/v1/public/events/\(id)/comics"
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
