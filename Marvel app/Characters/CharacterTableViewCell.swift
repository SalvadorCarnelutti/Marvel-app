//
//  CharacterTableViewCell.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    private lazy var eventImageView: UIImageView = {
        let eventImageView = UIImageView()
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(eventImageView)
        eventImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            eventImageView.heightAnchor.constraint(equalTo: eventImageView.widthAnchor),
            eventImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        return eventImageView
    }()
    
    private lazy var headingLabel: UILabel = {
        let headingLabel = UILabel()
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(headingLabel)
        headingLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headingLabel.numberOfLines = 0
        headingLabel.lineBreakMode = .byWordWrapping
        return headingLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(descriptionLabel)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byTruncatingTail
        return descriptionLabel
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 4
        return containerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            containerView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            containerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            eventImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            eventImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            headingLabel.leftAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: 16),
            headingLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -17)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: headingLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -17)
        ])
    }

    func configure(with item: Item) {
        selectionStyle = .none
        eventImageView.sd_setImage(with: item.imageURL)
        headingLabel.text = item.heading
        descriptionLabel.text = item.description
    }
}
