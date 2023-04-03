//
//  
//  EventComicsPresenter.swift
//  Marvel app
//
//  Created by Salvador on 4/2/23.
//
//

import UIKit

protocol EventComicsViewToPresenterProtocol: UIViewController {
    var eventItem: Item { get }
    var comicsCount: Int { get }
    func comicAt(row: Int) -> String
}

final class EventComicsPresenter: UIViewController {
    var viewEventComics: EventComicsPresenterToViewProtocol!
    var interactor: EventComicsPresenterToInteractorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewEventComics.loadView()
    }
    
    override func loadView() {
        super.loadView()
        view = viewEventComics
    }
}

// MARK: - ViewToPresenterProtocol
extension EventComicsPresenter: EventComicsViewToPresenterProtocol {
    var eventItem: Item {
        interactor.eventItem
    }
    
    var comicsCount: Int {
        interactor.comicsCount
    }
    
    func comicAt(row: Int) -> String {
        interactor.comicAt(row: row)
    }
}
