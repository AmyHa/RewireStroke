//
//  UIFontExtension.swift
//  RewireStroke
//
//  Created by Amy Ha on 20/02/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//


import UIKit

extension UIFont {
    
    static func robotoLight(size: CGFloat = 14) -> UIFont? {
        return UIFont(name: Constants.Font.Name.robotoLight, size: size)
    }
    
    static func robotoMedium(size: CGFloat = 14) -> UIFont? {
        return UIFont(name: Constants.Font.Name.robotoMedium, size: size)
    }
    
    static func robotoRegular(size: CGFloat = 14) -> UIFont? {
        return UIFont(name: Constants.Font.Name.robotoRegular, size: size)
    }
    
    static func robotoBold(size: CGFloat = 14) -> UIFont? {
        return UIFont(name: Constants.Font.Name.robotoBold, size: size)
    }
    
    static func rajdhaniSemiBold(size: CGFloat = 14) -> UIFont? {
        return UIFont(name: Constants.Font.Name.rajdhaniSemiBold, size: size)
    }
}
