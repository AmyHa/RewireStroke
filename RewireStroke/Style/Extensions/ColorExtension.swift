//
//  ColorExtension.swift
//  RewireStroke
//
//  Created by Amy Ha on 18/02/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import SwiftUI

extension Color {
    
    static func colorFromHexString(_ hexString: String) -> Color {
        
        var rgbValue: CUnsignedInt = 0
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 1 // bypass '#' character
        scanner.scanHexInt32(&rgbValue)
        return Color.init(.sRGB, red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
                          green: Double((rgbValue & 0xFF00) >> 8) / 255.0,
                          blue: Double(rgbValue & 0xFF) / 255.0)
    }
}
