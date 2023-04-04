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
        return eventHighlight
    }()
    
    private lazy var comicsDisplayView: ComicsDisplayView = {
        let comicsDisplayView = ComicsDisplayView()
        comicsDisplayView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(comicsDisplayView)
        return comicsDisplayView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            comicsDisplayView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            comicsDisplayView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            comicsDisplayView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            comicsDisplayView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - PresenterToViewProtocol
extension EventComicsView: EventComicsPresenterToViewProtocol {
    func loadView() {
        guard let presenter = presenter else { return }
        
        backgroundColor = .white
        eventHighlight.configure(with: presenter.eventItem)
        if presenter.isComicsEmpty {
            comicsDisplayView.configureAsEmpty(highlightView: eventHighlight, message: "No available comics to discuss")
        } else {
            comicsDisplayView.configureTable(comicDisplay: ComicDisplayStruct(dataSource: self, delegate: self))
        }
        setupConstraints()
    }
}

extension EventComicsView: UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HighlightComicView(highlightView: eventHighlight, message: "Comics to discuss")
    }
}
