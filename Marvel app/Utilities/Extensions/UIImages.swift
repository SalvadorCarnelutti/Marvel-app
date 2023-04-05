//
//  UIImages.swift
//  Marvel app
//
//  Created by Salvador on 4/1/23.
//

import UIKit

extension UIImage {
    private static func unwrappedImage(_ name: String) -> UIImage {
        return UIImage(systemName: name) ?? UIImage()
    }
    
    static var characters: UIImage { Self.unwrappedImage("person.crop.rectangle.stack") }
    static var events: UIImage { Self.unwrappedImage("calendar.badge.clock") }
    static var logout: UIImage { Self.unwrappedImage("rectangle.portrait.and.arrow.right") }
}
