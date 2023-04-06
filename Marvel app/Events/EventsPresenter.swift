//
//  
//  EventsPresenter.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//

import UIKit

protocol EventsViewToPresenterProtocol: UIViewController, ItemTableViewProtocol {
    func didSelectEventAt(row: Int)
    func viewLoaded()
}

final class EventsPresenter: TabViewController {
    private var eventItems = [EventCellItem]()
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
    
    private func loadEvents() {
        interactor.loadEvents { [weak self] events in
            let dateSortedEvents = events.filter { $0.start != nil }.map { $0.getItem }.sorted { $0.startDate! > $1.startDate! }
            let datelessEvents = events.filter { $0.start == nil }.map { $0.getItem }
            let combinedEvents = dateSortedEvents + datelessEvents
            self?.eventItems = combinedEvents
            self?.viewEvents.reloadTableViewData()
        }
    }
}

// MARK: - ViewToPresenterProtocol
extension EventsPresenter: EventsViewToPresenterProtocol {
    var itemsCount: Int {
        eventItems.count
    }
    
    func didSelectEventAt(row: Int) {
        interactor.loadComicsFor(eventId: eventItems[row].id) { [weak self] comicItems in
            guard let self = self else { return }
            self.router.presentComics(with: EventComics(eventItem: self.itemAt(row: row), comicItems: comicItems))
        }
    }
    
    func itemAt(row: Int) -> Item {
        eventItems[row]
    }
    
    func viewLoaded() {
        loadEvents()
    }
}

extension Event {
    var getItem: EventCellItem {
        EventCellItem(id: id,
                      imageURL: thumbnail.imageURL,
                      heading: title,
                      startDate: Date.formatAsDate(start, dateFormat: "yyyy-MM-dd hh:mm:ss"))
    }
}
