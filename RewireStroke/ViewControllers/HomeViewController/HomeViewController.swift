//
//  HomeViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 22/11/2020.
//  Copyright © 2020 Amy Ha. All rights reserved.
//

import UIKit
import SwiftUI
import Foundation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeView: UIView!
    
    private var host: UIHostingController<HomeScrollView>!
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        let homeScrollView = HomeScrollView()
        host = UIHostingController(rootView: homeScrollView)
        
        guard let hostView = host.view else { return }
        homeView.addSubview(hostView)
        
        // Add constraints
        hostView.translatesAutoresizingMaskIntoConstraints = false
        hostView.centerYAnchor.constraint(equalTo: homeView.centerYAnchor).isActive = true
        hostView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hostView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        hostView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
}
