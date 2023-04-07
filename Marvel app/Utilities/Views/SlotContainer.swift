//
//  SlotContainer.swift
//  Marvel app
//
//  Created by Salvador on 4/7/23.
//
import UIKit

final class SlotContainer: UIView {
    private lazy var roundedForeground: UIView = {
        let roundedForeground = UIView()
        roundedForeground.translatesAutoresizingMaskIntoConstraints = false
        addSubview(roundedForeground)
        roundedForeground.layer.cornerRadius = 4
        roundedForeground.backgroundColor = .systemBackground
        roundedForeground.clipsToBounds = true
        return roundedForeground
    }()
    
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addContent(_ view: UIView) {
        roundedForeground.addSubview(view)
    }
    
    private func setupConstraints() {
        roundedForeground.pinToSuperview()
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2.0
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 2).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
