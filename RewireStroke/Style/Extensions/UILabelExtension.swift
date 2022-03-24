//
//  UILabelExtension.swift
//  RewireStroke
//
//  Created by Amy Ha on 23/09/2020.
//  Copyright © 2020 Amy Ha. All rights reserved.
//

import UIKit

extension UILabel {
    func midTextColorChange (fullText: NSAttributedString , changeText: String, _ toColour: UIColor) {
        let strNumber: NSString = fullText.string as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(attributedString: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: toColour , range: range)
        attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.outfitBold() , range: range)
        self.attributedText = attribute
    }
}
 
