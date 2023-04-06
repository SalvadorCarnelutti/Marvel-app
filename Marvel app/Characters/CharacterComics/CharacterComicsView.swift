//
//  
//  CharacterComicsView.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//
//
import UIKit

protocol CharacterComicsPresenterToViewProtocol: UIView {
    var presenter: CharacterComicsViewToPresenterProtocol? { get set }
    func loadView()
}

final class CharacterComicsView: UIView {
    // MARK: - Properties
    weak var presenter: CharacterComicsViewToPresenterProtocol?
    
    private let characterHighlight = CharacterHighlight()
    
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
extension CharacterComicsView: CharacterComicsPresenterToViewProtocol {
    func loadView() {
        guard let presenter = presenter else { return }
        
        backgroundColor = .white
        characterHighlight.configure(with: presenter.characterItem)
        // TODO: View should be dumb
        if presenter.isComicsEmpty {
            comicsDisplayView.configureAsEmpty(highlightView: characterHighlight, message: "No available comics to discuss")
        } else {
            comicsDisplayView.configureTableWith(dataSource: self, delegate: self)
        }
        setupConstraints()
    }
}

extension CharacterComicsView: UITableViewDataSource, UITableViewDelegate {
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
        return HighlightComicView(highlightView: characterHighlight, message: "Appears in these comics")
    }
}
