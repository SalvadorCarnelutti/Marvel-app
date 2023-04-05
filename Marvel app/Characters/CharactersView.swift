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
        tableView.prefetchDataSource = self
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
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        // itemsCount is a count, we must consider the indices
        return indexPath.row >= (presenter?.itemsCount ?? 0) - 1
    }
}

// MARK: - PresenterToViewProtocol
extension CharactersView: CharactersPresenterToViewProtocol {
    func loadView() {
        backgroundColor = .secondarySystemBackground
        setupConstraints()
        // We must get some first items because prefetching depends on user being able to scroll with the tableView
        presenter?.loadCharacters { [weak self] newIndexPaths in
            // We are inserting new rows, not reloading them
            self?.tableView.insertRows(at: newIndexPaths, with: .automatic)
        }
    }
}

extension CharactersView: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
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
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let presenter = presenter else { return }
        print("ItemCount: \(presenter.itemsCount)")
        if indexPaths.contains(where: isLoadingCell) {
            print("IndexPaths: \(indexPaths)")
            presenter.loadCharacters { newIndexPaths in
                print("IndexPaths: \(newIndexPaths)")
                // We are inserting new rows, not reloading them
                tableView.insertRows(at: newIndexPaths, with: .automatic)
            }
        }
    }
}
