//
//  ProgressViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 12/03/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit
import SwiftUI
import Charts

class ProgressViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var progressView: UIView!
    
    private var host: UIHostingController<ProgressScrollView>!

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "Progress"
//        navigationController?.navigationBar.prefersLargeTitles = true

        // Need the below code to change bar title colour when using large titles – why?
//        let appearance = UINavigationBarAppearance()
//            appearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.outfitMedium(size: 32), NSAttributedString.Key.foregroundColor: Colours.primaryBlue]
//            self.navigationController?.navigationBar.standardAppearance = appearance
//            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Line chart things
//        lineChartView.delegate = self
//        containerView.addSubview(lineChartView)
//        lineChartView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            lineChartView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            lineChartView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            lineChartView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
//            lineChartView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
//        ])

        
        let progressScrollView = ProgressScrollView()
        host = UIHostingController(rootView: progressScrollView)
        
        guard let hostView = host.view else { return }
        progressView.addSubview(hostView)
        
        // Add constraints
        hostView.translatesAutoresizingMaskIntoConstraints = false
        hostView.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
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
