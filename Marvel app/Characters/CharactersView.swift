//
//  
//  CharactersView.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import UIKit

protocol CharactersPresenterToViewProtocol: UIView {
    var presenter: CharactersViewToPresenterProtocol? { get set }
    func loadView()
}

final class CharactersView: UIView {
    // MARK: - Properties
    weak var presenter: CharactersViewToPresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.register(CharacterTableViewCell.self)
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
extension CharactersView: CharactersPresenterToViewProtocol {
    func loadView() {
        backgroundColor = .secondarySystemBackground
        presenter?.loadCharacters(onSuccess: tableView.reloadData)
        setupConstraints()
    }
}

extension CharactersView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.itemsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter,
              let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            CharacterTableViewCell.assertCellFailure()
            return UITableViewCell()
        }
        
        cell.configure(with: presenter.itemAt(row: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.loadComicsAt(row: indexPath.row)
    }
}
