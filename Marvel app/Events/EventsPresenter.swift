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
}

final class EventsPresenter: TabViewController {
    var viewEvents: EventsPresenterToViewProtocol!
    var interactor: EventsPresenterToInteractorProtocol!
    
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
}
