//
//  Theme.swift
//  RewireStroke
//
//  Created by Amy Ha on 22/09/2020.
//  Copyright © 2020 Amy Ha. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct Colours {
    
    // Standard colour palette used across the app - UIColor
    
    // Primary
    static let primaryBlue = UIColor.colorFromHexString("#1A2D70")
    static let primaryLight = UIColor.colorFromHexString("#4E569F")
    static let primaryDark = UIColor.colorFromHexString("#000444")
    
    // Secondary
    static let secondaryLight = UIColor.colorFromHexString("#F4D2D3")
    static let secondaryDark = UIColor.colorFromHexString("#C1A1A2")
    
    // Accent
    static let accent = UIColor.colorFromHexString("#D73A49")
    
    // Background
    static let backgroundLightGrey = UIColor.colorFromHexString("#E5E5E5")
    
    // Grey
    static let grey01 = UIColor.colorFromHexString("#F6F6F6")
    static let grey02 = UIColor.colorFromHexString("#E8E8E8")
    static let grey03 = UIColor.colorFromHexString("#BDBDBD")
    static let grey04 = UIColor.colorFromHexString("#666666")
    
    // Theme
    static let primaryUpperLimb = UIColor.colorFromHexString("#6BC7E8")
    static let primaryLowerLimb = UIColor.colorFromHexString("#DCC817")
    static let primaryBalance = UIColor.colorFromHexString("#FF6A88")
    static let pain = UIColor.colorFromHexString("#FF6A88")
    static let mood = UIColor.colorFromHexString("#6BC7E8")
    static let fatigue = UIColor.colorFromHexString("#DCC817")
    
    // Standard colour palette used across the app - Color
    
    // Primary
    static  let primaryBlueColor = Color.colorFromHexString("#1A2D70")
    static let primaryLightColor = Color.colorFromHexString("#4E569F")
    static let primaryDarkColor = Color.colorFromHexString("#000444")
    
    // Secondary
    static let secondaryLightColor = Color.colorFromHexString("#F4D2D3")
    static let secondaryDarkColor = Color.colorFromHexString("#C1A1A2")
    
    // Accent
    static let accentColor = Color.colorFromHexString("#D73A49")
    
    // Background
    static let backgroundLightGreyColor = Color.colorFromHexString("#E5E5E5")
    
    // Grey
    static let grey01Color = Color.colorFromHexString("#F6F6F6")
    static let grey02Color = Color.colorFromHexString("#E8E8E8")
    static let grey03Color = Color.colorFromHexString("#BDBDBD")
    static let grey04Color = Color.colorFromHexString("#666666")
    
    // Theme
    static let primaryUpperLimbColor = Color.colorFromHexString("#6BC7E8")
    static let primaryLowerLimbColor = Color.colorFromHexString("#DCC817")
    static let primaryBalanceColor = Color.colorFromHexString("#FF6A88")
}

struct TextFields {
    
    // Rounded text fields with secondary light border
    
    static func setBorderTextField(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = Colours.secondaryLight.cgColor
        textField.backgroundColor = Colours.grey01
        textField.clipsToBounds = true
    }
    
    // Set placeholder text label in dark grey with custom text
    
    static func setTitleLabel(_ textField: UITextField, _ placeholderText: String) {
        
        // add a small indent before the start of the placeholder
        let greyPlaceholderText = NSMutableAttributedString(string: placeholderText,
                                                            attributes: [NSAttributedString.Key.foregroundColor: Colours.grey03, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        
        textField.attributedPlaceholder = greyPlaceholderText
    }
}

struct Buttons {
    
    // Rounded buttons with primary blue background and white text
    
    static func setBlueMainButton(_ button: UIButton) {
        button.layer.cornerRadius = 8
        button.backgroundColor = Colours.primaryBlue
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
}

struct Labels {
    
    // Different label styles used around the app
    
    // Unique label style used around the app
    static func setWarningLabelStyle(_ label: UILabel) {
        label.textColor = .red
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.red.cgColor
        label.backgroundColor = .white
    }
    
}
