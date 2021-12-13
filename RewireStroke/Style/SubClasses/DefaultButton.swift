//
//  DefaultButton.swift
//  RewireStroke
//
//  Created by Amy Ha on 20/02/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit

class DefaultButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initButton()
    }
    
    func initButton() {
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius = frame.size.height / 6
        setTitleColor(UIColor.white, for: .normal)
        adjustsImageWhenHighlighted = false
        tintColor = .clear
    }
    
    override open var isHighlighted: Bool {
        didSet {
        }
    }
    
    func buttonPressed(isSelected: Bool) {
        if isSelected {
            backgroundColor = isSelected ? Colours.primaryLight : Colours.secondaryLight
            let titleColour = isSelected ? UIColor.white : Colours.primaryDark
            setTitleColor(titleColour, for: .normal)
        }
    }
}
