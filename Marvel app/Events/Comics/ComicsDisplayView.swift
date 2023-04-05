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
    
    func configureTable(comicDisplay: ComicDisplay) {
        let comicsTableView = ComicsTableView()
        comicsTableView.configure(with: comicDisplay.dataSource, delegate: comicDisplay.delegate)
        stackView.addArrangedSubview(comicsTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

struct ComicDisplayStruct: ComicDisplay {
    let dataSource: UITableViewDataSource?
    let delegate: UITableViewDelegate?
}

protocol ComicDisplay {
    var dataSource: UITableViewDataSource? { get }
    var delegate: UITableViewDelegate? { get }
}
