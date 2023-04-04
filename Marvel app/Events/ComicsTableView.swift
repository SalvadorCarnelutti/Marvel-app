//
//  ComicsTableView.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//

import UIKit

final class ComicsTableView: UIView {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.register(ComicTableViewCell.self)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with dataSource: UITableViewDataSource?, delegate: UITableViewDelegate?) {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            tableView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
