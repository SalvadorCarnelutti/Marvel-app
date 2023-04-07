//
//  UIFont.swift
//  Marvel app
//
//  Created by Salvador on 4/7/23.
//

import Foundation
import UIKit

public enum RobotoType: String {
    case condensedRegular = "Condensed-Regular"
    case condensedBold = "Condensed-Bold"
    case regular = "-Regular"
}

extension UIFont {
    //        Roboto-Regular
    //        RobotoCondensed-Regular
    //        RobotoCondensed-Bold

    
    static func Roboto(type: RobotoType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Roboto\(type.rawValue)", size: size)!
    }
}
