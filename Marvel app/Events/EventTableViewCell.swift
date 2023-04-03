//
//  EventTableViewCell.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    private lazy var eventHighlight: EventHighlight = {
        let eventHighlight = EventHighlight()
        eventHighlight.translatesAutoresizingMaskIntoConstraints = false
        eventHighlight.backgroundColor = .systemBrown
        eventHighlight.layer.cornerRadius = 4
        addSubview(eventHighlight)
        return eventHighlight
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            eventHighlight.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            eventHighlight.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            eventHighlight.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            eventHighlight.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    func configure(with item: Item) {
        selectionStyle = .none
        eventHighlight.configure(with: item)
    }
}

struct EventCell: Item {
    var imageURL: String
    var heading: String
    var description: String
}
