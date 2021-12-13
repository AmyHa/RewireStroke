//
//  HomeViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 22/11/2020.
//  Copyright © 2020 Amy Ha. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var outerProgressView: UIView!
    @IBOutlet weak var activityStackView: UIStackView!

    
    @IBOutlet weak var upperLimbLabel: UILabel!
    @IBOutlet weak var lowerLimbLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    // Gesture recogniser
    var nextWorkoutTapGestureRecogniser: UIGestureRecognizer!
    
    var userManager: UserManager!
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        applyRingStyle()
        
        if UserManager.completedLLAssessment {
            // Exercise score labels
            upperLimbLabel.text = "0/3"
            lowerLimbLabel.text = "0/3"
            balanceLabel.text = "0/1"
        }
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.barTintColor = Colours.primaryDark
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = Colours.primaryDark
        
        // white labels text colour
        self.activityLabel.textColor = .white
        
        // Progress Labels text colour
        self.lowerLimbLabel.textColor = Colours.primaryLowerLimb
        self.upperLimbLabel.textColor = Colours.primaryUpperLimb
        self.balanceLabel.textColor = Colours.primaryBalance
        
        // round the corner of view
        self.tabBarController?.tabBar.barTintColor = .white
        
        // font
        activityLabel.font = UIFont(name: Constants.Font.Name.rajdhaniSemiBold, size: Constants.Font.Size.xxLarge)
        lowerLimbLabel.font = UIFont(name: Constants.Font.Name.rajdhaniSemiBold, size: Constants.Font.Size.xLarge)
        upperLimbLabel.font = UIFont(name: Constants.Font.Name.rajdhaniSemiBold, size: Constants.Font.Size.xLarge)
        balanceLabel.font = UIFont(name: Constants.Font.Name.rajdhaniSemiBold, size: Constants.Font.Size.xLarge)
    }
    

    
    private func applyRingStyle() {
        
        let ringBgColor = Color.colorFromHexString("#011D22")
        let ringEndColor = Color.white
        let ringBlueColor = Color.colorFromHexString("#7BACC0")
        let ringGreenColor = Color.colorFromHexString("#C9C47D")
        let ringRedColor = Color.colorFromHexString("#EB6460")
        
        let host1: UIHostingController<RingView>
        let host2: UIHostingController<RingView>
        let host3: UIHostingController<RingView>
        
        if !UserManager.completedLLAssessment {
            host1 = UIHostingController(rootView: RingView(percentage : 1, backgroundColor: ringEndColor, startColor: ringBlueColor, endColor: ringBlueColor, thickness: CGFloat(14), radius: CGFloat(125)))
            
            host2 = UIHostingController(rootView: RingView(percentage : 1, backgroundColor: ringEndColor, startColor: ringGreenColor, endColor:ringGreenColor, thickness: CGFloat(14), radius: CGFloat(100)))
            
            host3 = UIHostingController(rootView: RingView(percentage : 1, backgroundColor: ringEndColor, startColor: ringRedColor, endColor: ringRedColor, thickness: CGFloat(14), radius: CGFloat(75)))
        } else {
            host1 = UIHostingController(rootView: RingView(percentage : 0.01, backgroundColor: ringEndColor, startColor: ringBlueColor, endColor: ringBlueColor, thickness: CGFloat(14), radius: CGFloat(125)))
            
            host2 = UIHostingController(rootView: RingView(percentage : 0.01, backgroundColor: ringEndColor, startColor: ringGreenColor, endColor:ringGreenColor, thickness: CGFloat(14), radius: CGFloat(100)))
            
            host3 = UIHostingController(rootView: RingView(percentage : 0.01, backgroundColor: ringEndColor, startColor: ringRedColor, endColor: ringRedColor, thickness: CGFloat(14), radius: CGFloat(75)))
        }
        
        guard let hostView1 = host1.view else { return }
        guard let hostView2 = host2.view else { return }
        guard let hostView3 = host3.view else { return }
        
        hostView1.backgroundColor = .clear
        hostView2.backgroundColor = .clear
        hostView3.backgroundColor = .clear
    
        outerProgressView.addSubview(hostView1)
        outerProgressView.addSubview(hostView2)
        outerProgressView.addSubview(hostView3)
        
        // Add constraints
        hostView1.translatesAutoresizingMaskIntoConstraints = false
        hostView1.centerYAnchor.constraint(equalTo: outerProgressView.centerYAnchor).isActive = true
        hostView1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hostView1.widthAnchor.constraint(equalToConstant: 270).isActive = true
        hostView1.heightAnchor.constraint(equalToConstant: 270).isActive = true
        
        hostView2.translatesAutoresizingMaskIntoConstraints = false
        hostView2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hostView2.centerYAnchor.constraint(equalTo: outerProgressView.centerYAnchor).isActive = true
        hostView2.widthAnchor.constraint(equalToConstant: 250).isActive = true
        hostView2.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        hostView3.translatesAutoresizingMaskIntoConstraints = false
        hostView3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hostView3.centerYAnchor.constraint(equalTo: outerProgressView.centerYAnchor).isActive = true
        hostView3.widthAnchor.constraint(equalToConstant: 250).isActive = true
        hostView3.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        outerProgressView.backgroundColor = .clear
        outerProgressView.translatesAutoresizingMaskIntoConstraints = false

        // Exercise score labels
        upperLimbLabel.text = "0"
        lowerLimbLabel.text = "0"
        balanceLabel.text = "0"
    }
}
