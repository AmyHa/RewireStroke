//
//  UIButtonExtension.swift
//  RewireStroke
//
//  Created by Amy Ha on 23/09/2020.
//  Copyright © 2020 Amy Ha. All rights reserved.
//

import UIKit

extension UIButton {
    var titleLabelFont: UIFont! {
        get { return self.titleLabel?.font }
        set { self.titleLabel?.font = newValue }
    }    
}
