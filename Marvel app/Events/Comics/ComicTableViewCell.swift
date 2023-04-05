//
//  ComicTableViewCell.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//

import UIKit

final class ComicTableViewCell: UITableViewCell {
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        return descriptionLabel
    }()
    
    private lazy var separatorLine: UIView = {
        let separatorLine = UIView()
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorLine)
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorLine.backgroundColor = .lightGray
        return separatorLine
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            descriptionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            descriptionLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            separatorLine.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            separatorLine.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configure(with comic: String) {
        selectionStyle = .none
        descriptionLabel.text = comic
    }
}
