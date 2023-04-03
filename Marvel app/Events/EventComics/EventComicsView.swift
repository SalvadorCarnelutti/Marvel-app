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
        addSubview(eventHighlight)
        return eventHighlight
    }()
    
    private lazy var headingLabel: UILabel = {
        let headingLabel = UILabel()
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headingLabel)
        headingLabel.font = UIFont.systemFont(ofSize: 20)
        headingLabel.textAlignment = .center
        headingLabel.text = "COMICS TO DISCUSS"
        return headingLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.register(ComicTableViewCell.self)
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            eventHighlight.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            eventHighlight.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            eventHighlight.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: eventHighlight.bottomAnchor),
            headingLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 8),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            tableView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - PresenterToViewProtocol
extension EventComicsView: EventComicsPresenterToViewProtocol {
    func loadView() {
        guard let presenter = presenter else { return }
        
        backgroundColor = .white
        eventHighlight.configure(with: presenter.eventItem)
        setupConstraints()
    }
}

extension EventComicsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.comicsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter,
              let cell = tableView.dequeueReusableCell(withIdentifier: ComicTableViewCell.identifier, for: indexPath) as? ComicTableViewCell else {
            ComicTableViewCell.assertCellFailure()
            return UITableViewCell()
        }
        
        cell.configure(with: presenter.comicAt(row: indexPath.row))
        return cell
    }
}
