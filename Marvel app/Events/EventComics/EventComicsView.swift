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
    func configureAsEmpty()
    func configureTableView()
}

final class EventComicsView: UIView {
    // MARK: - Properties
    weak var presenter: EventComicsViewToPresenterProtocol?
    
    private let eventHighlight = EventHighlight()
    
    private lazy var comicsDisplayView: ComicsDisplayView = {
        let comicsDisplayView = ComicsDisplayView()
        comicsDisplayView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(comicsDisplayView)
        return comicsDisplayView
    }()
    
    private func setupConstraints() {
        comicsDisplayView.pinToSuperview()
    }
}

// MARK: - PresenterToViewProtocol
extension EventComicsView: EventComicsPresenterToViewProtocol {
    func loadView() {
        guard let presenter = presenter else { return }
        
        backgroundColor = .white
        eventHighlight.configure(with: presenter.eventItem)
        setupConstraints()
        presenter.viewLoaded()
    }
    
    func configureAsEmpty() {
        comicsDisplayView.configureAsEmpty(highlightView: eventHighlight, message: "comics_unavailable".localized)
    }
    
    func configureTableView() {
        comicsDisplayView.configureTableViewWith(dataSource: self, delegate: self)
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
        return HighlightComicView(highlightView: eventHighlight, message: "comics_available".localized)
    }
}
