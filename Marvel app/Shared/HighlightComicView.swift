//
//  HighlightComicView.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//

import UIKit

final class HighlightComicView: UIView {
    let highlightView: UIView
    
    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        messageLabel.font = .Roboto(type: .condensedRegular, size: 20)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        return messageLabel
    }()
    
    init(highlightView: UIView, message: String) {
        self.highlightView = highlightView
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        messageLabel.text = message.uppercased()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        highlightView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(highlightView)
        
        NSLayoutConstraint.activate([
            highlightView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            highlightView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            highlightView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: highlightView.bottomAnchor, constant: 40),
            messageLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            messageLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
