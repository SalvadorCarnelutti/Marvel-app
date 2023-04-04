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
    
    private lazy var characterHighlight: CharacterHighlight = {
        let characterHighlight = CharacterHighlight()
//        characterHighlight.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(characterHighlight)
        return characterHighlight
    }()
    
    private lazy var comicsTableView: ComicsTableView = {
        let comicsTableView = ComicsTableView()
        comicsTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(comicsTableView)
        comicsTableView.configure(with: self, delegate: self)
        return comicsTableView
    }()
    
    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            characterHighlight.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            characterHighlight.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
//            characterHighlight.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
//        ])
        
        NSLayoutConstraint.activate([
//            comicsTableView.topAnchor.constraint(equalTo: characterHighlight.bottomAnchor),
            comicsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            comicsTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            comicsTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            comicsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - PresenterToViewProtocol
extension CharacterComicsView: CharacterComicsPresenterToViewProtocol {
    func loadView() {
        guard let presenter = presenter else { return }
        
        backgroundColor = .white
        characterHighlight.configure(with: presenter.characterItem)
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
        return characterHighlight
    }
}
