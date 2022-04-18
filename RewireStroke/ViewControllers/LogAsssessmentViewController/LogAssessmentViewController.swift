//
//  LogAssessmentViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 25/03/2022.
//  Copyright © 2022 Amy Ha. All rights reserved.
//

import UIKit
import SwiftUI

class LogAssessmentViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    private var host: UIHostingController<LogAssessmentView>!
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        let logAssessmentView = LogAssessmentView()
        host = UIHostingController(rootView: logAssessmentView)
        
        guard let hostView = host.view else { return }
        
        containerView.addSubview(hostView)
        
        // Add constraints
        hostView.translatesAutoresizingMaskIntoConstraints = false
        hostView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        hostView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hostView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        hostView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
}
