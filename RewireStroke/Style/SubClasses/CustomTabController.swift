//
//  CustomTabController.swift
//  RewireStroke
//
//  Created by Amy Ha on 08/04/2022.
//  Copyright © 2022 Amy Ha. All rights reserved.
//

import UIKit

class CustomTabController: UITabBarController {
    
    var kBarHeight = CGFloat(90);
    
    override func viewDidLayoutSubviews() {
        tabBar.frame.size.height = kBarHeight
        tabBar.frame.origin.y = view.frame.height-kBarHeight
    }
}
