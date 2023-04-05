//
//  BaseViewController.swift
//  Marvel app
//
//  Created by Salvador on 4/4/23.
//

import UIKit

protocol BaseViewProtocol: UIViewController {
    func showLoader()
    func hideLoader()
    func presentOKAlert(title: String, message: String)
}

class BaseViewController: UIViewController, BaseViewProtocol {
    private struct Constraints {
        static let ActivityIndicatorSize: CGFloat = 80
    }
    
    private lazy var activityIndicator: ActivityIndicator = {
        let activityIndicator = ActivityIndicator()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func showLoader() {
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        activityIndicator.stopAnimating()
    }
    
    func presentOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        activityIndicator.centerInSuperview()
        activityIndicator.constraintSizeWithEqualSides(Constraints.ActivityIndicatorSize)
    }
}
