//
//  
//  EventsPresenter.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//

import UIKit

protocol EventsViewToPresenterProtocol: UIViewController {
    var itemsCount: Int { get }
    func loadEvents(onSuccess: @escaping () -> ())
    func loadComicsAt(row: Int)
    func itemAt(row: Int) -> Item
}

final class EventsPresenter: TabViewController {
    var viewEvents: EventsPresenterToViewProtocol!
    var interactor: EventsPresenterToInteractorProtocol!
    var router: EventsPresenterToRouterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewEvents.loadView()
    }
    
    override func loadView() {
        super.loadView()
        view = viewEvents
    }
}

// MARK: - ViewToPresenterProtocol
extension EventsPresenter: EventsViewToPresenterProtocol {
    var itemsCount: Int {
        interactor.itemsCount
    }
    
    func loadEvents(onSuccess: @escaping () -> ()) {
        interactor.loadEvents(onSuccess: onSuccess)
    }
    
    func loadComicsAt(row: Int) {
        interactor.loadComicsAt(row: row, onSuccess: router.presentComics)
    }
    
    func itemAt(row: Int) -> Item {
        interactor.itemAt(row: row)
    }
}
