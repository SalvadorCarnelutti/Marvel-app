//
//  UIView.swift
//  Marvel app
//
//  Created by Salvador on 4/4/23.
//

import UIKit

extension UIView {
    func pinToSuperview() {
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
    
    func centerInSuperview() {
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
    
    func constraintSizeWithEqualSides(_ size: CGFloat) {
        constraintSize(CGSize(width: size, height: size))
    }
    
    func constraintSize(_ size: CGSize) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: size.height),
            widthAnchor.constraint(equalToConstant: size.width)
        ])
    }
}

extension UIView {
    var allSubviews: [UIView] {
        var allHierarchySubviews = subviews
        subviews.forEach({ allHierarchySubviews += $0.allSubviews })
        
        return allHierarchySubviews
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
}
