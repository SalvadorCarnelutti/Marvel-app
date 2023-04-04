//
//  CharacterHighlight.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//

import UIKit
import SDWebImage

final class CharacterHighlight: UIView {
    private lazy var characterImageView: UIImageView = {
        let characterImageView = UIImageView()
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(characterImageView)
        characterImageView.contentMode = .scaleAspectFit
        characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor).isActive = true
        
        return characterImageView
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
            characterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            characterImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            characterImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 22),
            descriptionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 52),
            descriptionLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -17)
        ])
    }
    
    func configure(with item: Item) {
        characterImageView.sd_setImage(with: item.imageURL)
        descriptionLabel.text = item.description
    }
}
