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
        containerView.addContent(eventHighlight)
        eventHighlight.clipsToBounds = true
        eventHighlight.layer.cornerRadius = 4
        return eventHighlight
    }()
    
    private lazy var containerView: SlotContainer = {
        let containerView = SlotContainer()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
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
            containerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            containerView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
        
        eventHighlight.pinToSuperview()
    }
    
    func configure(with item: Item) {
        selectionStyle = .none
        eventHighlight.configure(with: item)
    }
}
