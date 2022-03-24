//
//  FontExtension.swift
//  RewireStroke
//
//  Created by Amy Ha on 12/03/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//
// Extension for Font to be used with SwiftUI classes

import SwiftUI

extension Font {
    
    static func robotoLight(size: CGFloat = 14) -> Font? {
        return Font.custom(Constants.Font.Name.robotoLight, size: size)
    }
    
    static func robotoMedium(size: CGFloat = 14) -> Font? {
        return Font.custom(Constants.Font.Name.robotoMedium, size: size)
    }
    
    static func robotoRegular(size: CGFloat = 14) -> Font? {
        return Font.custom(Constants.Font.Name.robotoRegular, size: size)
    }
    
    static func robotoBold(size: CGFloat = 14) -> Font? {
        return Font.custom(Constants.Font.Name.robotoBold, size: size)
    }
    
    static func rajdhaniSemiBold(size: CGFloat = 14) -> Font? {
        return Font.custom(Constants.Font.Name.rajdhaniSemiBold, size: size)
    }
    
    static func outfitRegular(size: CGFloat = 14) -> Font? {
        return Font.custom(Constants.Font.Name.outfitRegular, size: size)
    }
    
    static func outfitBold(size: CGFloat = 14) -> Font? {
        return Font.custom(Constants.Font.Name.outfitBold, size: size)
    }
}
