//
//  WarningLabel.swift
//  RewireStroke
//
//  Created by Amy Ha on 18/02/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit

@IBDesignable class WarningLabel: PaddingLabel {
    
    override func drawText(in rect: CGRect) {
        
        self.textColor = .red
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = frame.size.height / 15
        self.layer.borderColor = UIColor.red.cgColor
        self.backgroundColor = .white
        super.drawText(in: rect)
    }
}
