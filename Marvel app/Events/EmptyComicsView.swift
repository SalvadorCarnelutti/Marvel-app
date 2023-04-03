//
//  EmptyComicsView.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//

import UIKit

final class EmptyComicsView: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        imageView.image = .tray
        return imageView
    }()
    
    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        messageLabel.font = .systemFont(ofSize: 20)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        return messageLabel
    }()
    
    init(message: String) {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        messageLabel.text = message
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            messageLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            messageLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
