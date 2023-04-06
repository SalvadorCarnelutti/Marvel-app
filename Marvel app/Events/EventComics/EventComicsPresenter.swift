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
    func viewLoaded()
}

final class EventComicsPresenter: BaseViewController {
    private let eventComics: EventComics
    var viewEventComics: EventComicsPresenterToViewProtocol!
    
    init(eventComics: EventComics) {
        self.eventComics = eventComics
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        eventComics.eventItem
    }
    
    var comicsCount: Int {
        eventComics.comicItems.count
    }
    
    func comicAt(row: Int) -> String {
        eventComics.comicItems[row]
    }
    
    func viewLoaded() {
        if eventComics.comicItems.isEmpty {
            viewEventComics.configureAsEmpty()
        } else {
            viewEventComics.configureTableView()
        }
    }
}

struct EventComics {
    let eventItem : Item
    let comicItems: [String]
}
