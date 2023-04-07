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
        interactor.loadEvents { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let events):
                self.eventItems = self.sortedEvents(events)
                self.viewEvents.reloadTableViewData()
            case .failure(let error):
                self.presentOKAlert(title: "alert_event_title".localized, message: error.localizedDescription)
            }
        }
    }
    
    private func sortedEvents(_ events: [Event]) -> [EventCellItem] {
        let dateSortedEvents = events.filter { $0.start != nil }.map { $0.getItem }.sorted { $0.startDate! > $1.startDate! }
        let datelessEvents = events.filter { $0.start == nil }.map { $0.getItem }
        let combinedEvents = dateSortedEvents + datelessEvents
        return combinedEvents
    }
}

// MARK: - ViewToPresenterProtocol
extension EventsPresenter: EventsViewToPresenterProtocol {
    var itemsCount: Int {
        eventItems.count
    }
    
    func didSelectEventAt(row: Int) {
        interactor.loadComicsFor(eventId: eventItems[row].id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let comicItems):
                self.router.presentComics(with: EventComics(eventItem: self.itemAt(row: row), comicItems: comicItems))
            case .failure(let error):
                self.presentOKAlert(title: "alert_comics_title".localized, message: error.localizedDescription)
            }
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
