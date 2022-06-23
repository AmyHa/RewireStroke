//
//  GradientButton.swift
//  RewireStroke
//
//  Created by Amy Ha on 10/05/2022.
//  Copyright © 2022 Amy Ha. All rights reserved.
//

import UIKit

class GradientButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [Colours.primaryBlue, Colours.primaryDark]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = 15
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
