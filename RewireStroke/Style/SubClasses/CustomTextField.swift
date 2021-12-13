//
//  CustomTextField.swift
//  RewireStroke
//
//  Created by Amy Ha on 23/09/2020.
//  Copyright © 2020 Amy Ha. All rights reserved.
//

import UIKit

/* Custom text field for those that have a rightView e.g. the password text field which has the 'Show' button to the right */

class CustomTextField: UITextField {
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 16
        return rect
    }
    
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        var rect = super.placeholderRect(forBounds: bounds)
//        rect.origin.x += 11
//        return rect
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        var rect = super.editingRect(forBounds: bounds)
//        rect.origin.x += 11
//        return rect
//    }

//    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
//                var rect = super.leftViewRect(forBounds: bounds)
//                rect.origin.x += 11
//                return rect
//    }
}
