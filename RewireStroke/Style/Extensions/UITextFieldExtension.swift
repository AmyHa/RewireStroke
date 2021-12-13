//
//  UITextFieldExtension.swift
//  RewireStroke
//
//  Created by Amy Ha on 23/09/2020.
//  Copyright © 2020 Amy Ha. All rights reserved.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
