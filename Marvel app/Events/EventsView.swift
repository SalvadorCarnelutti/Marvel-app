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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - PresenterToViewProtocol
extension EventsView: EventsPresenterToViewProtocol {
    func loadView() {
        backgroundColor = .white
        setupConstraints()
    }
}

extension EventsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EventTableViewCell()
        cell.configure(with: EventCell(heading: "Hello", description: "There"))
        
        return cell
    }
}
