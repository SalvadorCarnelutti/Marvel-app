//
//  ComicsTableView.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//

import UIKit

final class ComicsTableView: UIView {
    private lazy var headingLabel: UILabel = {
        let headingLabel = UILabel()
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headingLabel)
        headingLabel.font = UIFont.systemFont(ofSize: 20)
        headingLabel.textAlignment = .center
        headingLabel.numberOfLines = 0
        headingLabel.lineBreakMode = .byWordWrapping
        return headingLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.register(ComicTableViewCell.self)
        tableView.estimatedRowHeight = UITableView.automaticDimension
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
    
    func configure(with dataSource: UITableViewDataSource?, headingText: String?) {
        tableView.dataSource = dataSource
        headingLabel.text = headingText?.uppercased()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            headingLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            headingLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 8),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            tableView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
