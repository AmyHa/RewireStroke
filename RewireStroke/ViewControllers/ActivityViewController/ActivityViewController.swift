//
//  ActivityViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 08/03/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit
import SwiftUI
import Foundation

class ActivityViewController: UIViewController {

    @IBOutlet weak var activityView: UIView!

    private var host: UIHostingController<ActivityScrollView>!
    
    var activityViewModel: ActivityViewModel!
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        
        let data = WorkoutPlaceholderData()
        activityViewModel = ActivityViewModel(data: data)
        
        let activityScrollView = ActivityScrollView(activityViewModel)
        host = UIHostingController(rootView: activityScrollView)
        
        guard let hostView = host.view else { return }
        activityView.addSubview(hostView)
        
        // Add constraints
        hostView.translatesAutoresizingMaskIntoConstraints = false
        hostView.centerYAnchor.constraint(equalTo: activityView.centerYAnchor).isActive = true
        hostView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hostView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        hostView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
}
