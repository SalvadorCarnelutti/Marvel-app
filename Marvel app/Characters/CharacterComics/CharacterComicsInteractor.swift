//
//  
//  CharacterComicsInteractor.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//
//
import Foundation

protocol CharacterComicsPresenterToInteractorProtocol: ComicsTableViewProtocol {
    var characterItem: Item { get }
    var characterName: String { get }
}

// MARK: - PresenterToInteractorProtocol
final class CharacterComicsInteractor: CharacterComicsPresenterToInteractorProtocol {
    let characterComics: CharacterComics
    
    init(characterComics: CharacterComics) {
        self.characterComics = characterComics
    }
    
    var characterItem: Item {
        characterComics.characterItem
    }
    
    var characterName: String {
        characterComics.characterItem.heading
    }
    
    var comicsCount: Int {
        return characterComics.comicItems.count
    }
    
    var isComicsEmpty: Bool {
        characterComics.comicItems.isEmpty
    }
    
    func comicAt(row: Int) -> String {
        characterComics.comicItems[row]
    }
}

// MARK: - Entity
struct CharacterComics {
    let characterItem : Item
    let comicItems: [String]
}
