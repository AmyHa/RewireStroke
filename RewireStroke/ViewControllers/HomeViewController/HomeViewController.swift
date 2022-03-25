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
    
    private let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.cornerRadius = 30
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.backgroundColor = Colours.primaryDark
        
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
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
        
        view.addSubview(floatingButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(
            x: view.frame.size.width - 70,
            y: view.frame.size.height - 160,
            width: 60,
            height: 60)
    }
}
