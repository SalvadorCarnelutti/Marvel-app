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
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var comicsTableView: ComicsTableView = {
        let comicsTableView = ComicsTableView()
        comicsTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(comicsTableView)
        return comicsTableView
    }()
    
    private lazy var emptyComicsView: EmptyComicsView = {
        let emptyComicsView = EmptyComicsView(message: "No comics to see here".uppercased())
        emptyComicsView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emptyComicsView)
        return emptyComicsView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with comicDisplay: ComicDisplay) {
        if comicDisplay.isComicsEmpty {
            stackView.addArrangedSubview(emptyComicsView)
            let spacer = UIView()
            spacer.setContentHuggingPriority(.defaultHigh, for: .vertical)
            stackView.addArrangedSubview(spacer)
        } else {
            comicsTableView.configure(with: comicDisplay.dataSource, headingText: comicDisplay.headingText)
            stackView.addArrangedSubview(comicsTableView)
        }
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
    let headingText: String?
    let isComicsEmpty: Bool
}

protocol ComicDisplay {
    var dataSource: UITableViewDataSource? { get }
    var headingText: String? { get }
    var isComicsEmpty: Bool { get }
}
