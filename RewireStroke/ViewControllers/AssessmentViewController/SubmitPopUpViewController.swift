//
//  SubmitPopUpViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 28/02/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit

class SubmitPopUpViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstSubmissionTextLabel: UILabel!
    @IBOutlet weak var secondSubmissionTextLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var finishedWorkoutDelegate: FinishedWorkoutDelegate!
    var activityViewModel: ActivityViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }

    private func setUpUI() {
        titleLabel.font = UIFont.robotoMedium(size: 28)
        firstSubmissionTextLabel.font = UIFont.robotoRegular(size: 14)
        secondSubmissionTextLabel.font = UIFont.robotoRegular(size: 14)
        
        titleLabel.textColor = Colours.primaryDark
        firstSubmissionTextLabel.textColor = Colours.primaryDark
        secondSubmissionTextLabel.textColor = Colours.primaryDark
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        
        backButton.backgroundColor = Colours.grey03
        backButton.setTitleColor(.white, for: .normal)
        backButton.titleEdgeInsets.left = 10
        backButton.titleEdgeInsets.right = 10
        
        correctButton.backgroundColor = Colours.accent
        correctButton.setTitleColor(.white, for: .normal)
        correctButton.titleEdgeInsets.left = 10
        correctButton.titleEdgeInsets.right = 10
        
        correctButton.titleLabelFont = UIFont.robotoBold(size: 11)
        backButton.titleLabelFont = UIFont.robotoBold(size: 11)
        
        containerView.layer.cornerRadius = 10
        setUpExitButton()
    }
    
    private func setUpExitButton() {
        let icon = UIImage(named: "close")!
        closeButton.tintColor = Colours.grey03
        closeButton.setImage(icon, for: .normal)
        closeButton.imageView?.contentMode = .scaleAspectFit
    }
    
    
    // MARK:- Actions
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCloseButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onCorrectButtonPressed(_ sender: Any) {
        // Go to home page
        self.dismiss(animated: true, completion: nil)
        finishedWorkoutDelegate.didCloseWorkout()
        // Set the assessment score
        UserManager.completedLLAssessment = true
    
        // Here we can do the logic to update the workouts after the assessment is complete
        
        // Check LL assessment score
        activityViewModel.setUpLLWorkout()
    }
}

protocol FinishedWorkoutDelegate {
    func didCloseWorkout()
}
