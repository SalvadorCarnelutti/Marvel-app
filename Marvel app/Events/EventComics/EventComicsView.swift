//
//  
//  EventComicsView.swift
//  Marvel app
//
//  Created by Salvador on 4/2/23.
//
//
import UIKit

protocol EventComicsPresenterToViewProtocol: UIView {
    var presenter: EventComicsViewToPresenterProtocol? { get set }
    func loadView()
}

final class EventComicsView: UIView {
    // MARK: - Properties
    weak var presenter: EventComicsViewToPresenterProtocol?
    
    private lazy var eventHighlight: EventHighlight = {
        let eventHighlight = EventHighlight()
        eventHighlight.translatesAutoresizingMaskIntoConstraints = false
        eventHighlight.backgroundColor = .systemBrown
        eventHighlight.layer.cornerRadius = 4
        addSubview(eventHighlight)
        return eventHighlight
    }()
        
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            eventHighlight.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            eventHighlight.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            eventHighlight.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

// MARK: - PresenterToViewProtocol
extension EventComicsView: EventComicsPresenterToViewProtocol {
    func loadView() {
        backgroundColor = .white
        setupConstraints()
    }
}
