//
//  InfoViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 17/06/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit
import SwiftUI
import Foundation

class InfoViewController: UIViewController {
    
    @IBOutlet weak var infoView: UIView!
    
    private var host: UIHostingController<InfoListView>!
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoListView = InfoListView()
        host = UIHostingController(rootView: infoListView)
        
        guard let hostView = host.view else { return }
        infoView.addSubview(hostView)
        
        // Add constraints
        hostView.translatesAutoresizingMaskIntoConstraints = false
        hostView.centerYAnchor.constraint(equalTo: infoView.centerYAnchor).isActive = true
        hostView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hostView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        hostView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
//        setupUI()
    }

    private func setupUI() {

        self.title = "Information"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Need the below code to change bar title colour when using large titles – why?
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colours.primaryLowerLimb
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.rajdhaniSemiBold(size: 30), NSAttributedString.Key.foregroundColor: Colours.primaryBlue]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

}
