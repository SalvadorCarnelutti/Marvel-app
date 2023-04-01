//
//  
//  EventsView.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import UIKit

protocol EventsPresenterToViewProtocol: UIView {
    var presenter: EventsViewToPresenterProtocol? { get set }
    func loadView()
}

final class EventsView: UIView {
    // MARK: - Properties
    weak var presenter: EventsViewToPresenterProtocol?
    
    private func setupConstraints() {
        
    }
}

// MARK: - PresenterToViewProtocol
extension EventsView: EventsPresenterToViewProtocol {
    func loadView() {
        backgroundColor = .white
        setupConstraints()
    }
}
