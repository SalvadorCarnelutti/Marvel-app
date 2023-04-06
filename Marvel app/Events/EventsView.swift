//
//  
//  EventsView.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import UIKit
import Alamofire

protocol EventsPresenterToViewProtocol: UIView {
    var presenter: EventsViewToPresenterProtocol? { get set }
    func loadView()
    func reloadTableViewData()
}

final class EventsView: UIView {
    // MARK: - Properties
    weak var presenter: EventsViewToPresenterProtocol?
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.register(EventTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            tableView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }    
}

// MARK: - PresenterToViewProtocol
extension EventsView: EventsPresenterToViewProtocol {
    func loadView() {
        backgroundColor = .secondarySystemBackground
        setupConstraints()
        presenter?.viewLoaded()
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
}

extension EventsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.itemsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter,
              let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell else {
            EventTableViewCell.assertCellFailure()
            return UITableViewCell()
        }
        
        cell.configure(with: presenter.itemAt(row: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectEventAt(row: indexPath.row)
    }
}
