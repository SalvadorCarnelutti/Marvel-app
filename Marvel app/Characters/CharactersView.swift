//
//  
//  CharactersView.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//
//
import UIKit

protocol CharactersPresenterToViewProtocol: UIView {
    var presenter: CharactersViewToPresenterProtocol? { get set }
    func loadView()
}

final class CharactersView: UIView {
    // MARK: - Properties
    weak var presenter: CharactersViewToPresenterProtocol?
    
    private func setupConstraints() {
        
    }
}

// MARK: - PresenterToViewProtocol
extension CharactersView: CharactersPresenterToViewProtocol {
    func loadView() {
        backgroundColor = .white
        setupConstraints()
    }
}
