//
//  EventHighlight.swift
//  Marvel app
//
//  Created by Salvador on 4/2/23.
//

import UIKit
import SDWebImage

class EventHighlight: UIView {
    private lazy var eventImageView: UIImageView = {
        let eventImageView = UIImageView()
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(eventImageView)
        eventImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            eventImageView.heightAnchor.constraint(equalTo: eventImageView.widthAnchor),
            eventImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        return eventImageView
    }()
    
    private lazy var headingLabel: UILabel = {
        let headingLabel = UILabel()
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headingLabel)
        headingLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headingLabel.numberOfLines = 0
        headingLabel.lineBreakMode = .byWordWrapping
        return headingLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        return descriptionLabel
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 17),
            eventImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            eventImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 17),
        ])
        
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: eventImageView.topAnchor, constant: 2),
            headingLabel.leftAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: 33),
            headingLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -17)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: headingLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -17)
        ])
    }
    
    func configure(with item: Item) {
        eventImageView.sd_setImage(with: item.imageURL)
        headingLabel.text = item.heading
        descriptionLabel.text = item.description
    }
}
