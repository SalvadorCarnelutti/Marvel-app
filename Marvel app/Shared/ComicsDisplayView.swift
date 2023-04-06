//
//  ComicsDisplayView.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//

import UIKit

final class ComicsDisplayView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAsEmpty(highlightView: UIView, message: String) {
        stackView.addArrangedSubview(HighlightComicView(highlightView: highlightView, message: message))
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultHigh, for: .vertical)
        stackView.addArrangedSubview(spacer)
    }
    
    func configureTableWith(dataSource: UITableViewDataSource?, delegate: UITableViewDelegate?) {
        let comicsTableView = ComicsTableView()
        comicsTableView.configureWith(dataSource: dataSource, delegate: delegate)
        stackView.addArrangedSubview(comicsTableView)
    }
    
    private func setupConstraints() {
        stackView.pinToSuperview()
    }
}
