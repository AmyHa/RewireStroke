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
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class ProgressViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    
    var lineChartView = CustomChartView(viewModel: ChartViewModel(results: [Result(id: UUID(), type: "pain", value: 1, date: 45545)]))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Progress"
        navigationController?.navigationBar.prefersLargeTitles = true

        // Need the below code to change bar title colour when using large titles – why?
        let appearance = UINavigationBarAppearance()
//            appearance.backgroundColor = Colours.primaryLowerLimb
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.robotoMedium(size: 32), NSAttributedString.Key.foregroundColor: Colours.primaryBlue]
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Line chart things
        lineChartView.delegate = self
        containerView.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineChartView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            lineChartView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            lineChartView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            lineChartView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        setImages()
    }
    
    func setImages() {
        topImage.image = UIImage(named: "happy-face.png")
        bottomImage.image = UIImage(named: "sad-face.png")
    }
}
