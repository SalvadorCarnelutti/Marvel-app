//
//  
//  EventComicsPresenter.swift
//  Marvel app
//
//  Created by Salvador on 4/2/23.
//
//

import UIKit

protocol EventComicsViewToPresenterProtocol: UIViewController, ComicsTableViewProtocol {
    var eventItem: Item { get }
    var isComicsEmpty: Bool { get }
}

final class EventComicsPresenter: BaseViewController {
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
    
    var isComicsEmpty: Bool {
        interactor.isComicsEmpty
    }
    
    func comicAt(row: Int) -> String {
        interactor.comicAt(row: row)
    }
}
