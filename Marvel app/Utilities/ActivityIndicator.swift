//
//  ActivityIndicator.swift
//  Marvel app
//
//  Created by Salvador on 4/4/23.
//

import UIKit

class ActivityIndicator: UIView {
    private struct Constants {
        static let ActivityIndicatorSize: CGFloat = 40
        static let CornerRadius: CGFloat = 16
        static let BackgroundLoadingViewColor: UIColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        static let MainContainerAlpha: CGFloat = 0.9
        static let MainContainerColor: UIColor = .white
    }
    
    private lazy var mainContainer: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.MainContainerColor
        view.alpha = Constants.MainContainerAlpha
        view.clipsToBounds = true
        view.layer.cornerRadius = Constants.CornerRadius
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    private lazy var backgroundLoadingView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        view.layer.cornerRadius = Constants.CornerRadius
        view.backgroundColor = Constants.BackgroundLoadingViewColor
        
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.style = .large
        activityIndicatorView.color = .white
        activityIndicatorView.hidesWhenStopped = true
        
        return activityIndicatorView
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        bringSubviewToFront(mainContainer)
        mainContainer.isHidden = false
        backgroundLoadingView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        mainContainer.isHidden = true
        backgroundLoadingView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    private func setupViews() {
        addSubview(mainContainer)
        mainContainer.addSubview(backgroundLoadingView)
        backgroundLoadingView.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
    }
    
    private func setupConstraints() {
        mainContainer.pinToSuperview()
        backgroundLoadingView.pinToSuperview()
        activityIndicator.centerInSuperview()
        activityIndicator.constraintSizeWithEqualSides(Constants.ActivityIndicatorSize)
    }
}
