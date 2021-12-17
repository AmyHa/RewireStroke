//
//  AssessmentViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 18/02/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit
import FirebaseStorage
import AVFoundation
import AVKit

class AssessmentViewController: UIViewController, FinishedWorkoutDelegate {
    func didCloseWorkout() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    var activityViewModel: ActivityViewModel
    var assessmentViewModel = AssessmentViewModel()
    
    init(activityViewModel: ActivityViewModel) {
        self.activityViewModel = activityViewModel
        super.init(nibName: Constants.View.assessmentViewController, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let playerViewController = AVPlayerViewController()
    
    // MARK: - Outlets
    @IBOutlet weak var warningLabel: WarningLabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var selectionWarningLabel: WarningLabel!
    @IBOutlet weak var assessmentLabel: UILabel!
    
    @IBOutlet weak var answerButtonsStackView: UIStackView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var videoContainerView: UIView!
    
    private var questions = [Question]()
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setUpUI()
        self.setQuestionText(questionIndex: currentIndex)
        self.setUpButtonResponses()

        self.prepareForPlayback()
        
        addVideoView()
   }
    
    private func setUpUI() {
        self.title = "Assessment"
        
        for view in answerButtonsStackView.subviews {
            if let button = view as? DefaultButton {
                button.backgroundColor = Colours.secondaryLight
                button.titleLabel?.font = UIFont.robotoBold()
                button.setTitleColor(Colours.primaryDark, for: .normal)
            }
        }
        
        warningLabel.text = "Please answer the questions accurately so we can deliver content appropriate for your loved one."
        Labels.setWarningLabelStyle(warningLabel)
        Labels.setWarningLabelStyle(selectionWarningLabel)
        
        warningLabel.font = UIFont.robotoRegular()
        questionLabel.font = UIFont.robotoRegular()
        selectionWarningLabel.font = UIFont.robotoRegular()
        assessmentLabel.font = UIFont.robotoRegular()
        
        assessmentLabel.textColor = Colours.primaryDark
        questionLabel.textColor = Colours.primaryDark
        
        // Make the selection warning label invisible initially
        selectionWarningLabel.alpha = 0
        
    }
    
    private func setUpButtonResponses() {
        
        for view in answerButtonsStackView.subviews {
            if let button = view as? DefaultButton {
                button.addTarget(self, action: #selector(self.answerButtonTapped), for: .touchUpInside)
            }
        }
        
        backButton.addTarget(self, action: #selector(self.backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func answerButtonTapped(_ button: UIButton) {
        
        // if the button is selected, then return to unselected state and exit
        if button.isSelected {
            button.backgroundColor = Colours.secondaryLight
            button.setTitleColor(Colours.primaryDark, for: .normal)
            button.isSelected = !button.isSelected
        } else {
            // if it's unselected, then we should return all other buttons to unselected state
            // then continue with selected the button
            returnAnswerButtonsToUnselectedState()
            
            button.isSelected = !button.isSelected
            button.backgroundColor = Colours.primaryBlue
            button.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc private func backButtonTapped(_ button : DefaultButton) {

        // return all buttons to unselected state
        returnAnswerButtonsToUnselectedState()
        
        // then we return to prev question
        currentIndex-=1
        setQuestionText(questionIndex: currentIndex)
    }
    
    @objc private func nextButtonTapped(_ button : DefaultButton) {
        
        // First, stop playing the current video!
        playerViewController.player?.pause()
    
        // Only move on if we have an answer selected 
        if isAnswerSelected() {
            
            // then we move on to next question
            currentIndex+=1
            
            if currentIndex >= assessmentViewModel.questions.count || currentIndex < 0 {
                let popupViewController = SubmitPopUpViewController.init(nibName: Constants.View.submitPopUpViewController, bundle: nil)
                popupViewController.modalPresentationStyle = .popover
                popupViewController.finishedWorkoutDelegate = self
                popupViewController.activityViewModel = activityViewModel
                present(popupViewController, animated: true)
            } else {
                self.setQuestionText(questionIndex: currentIndex)
                self.setButtons(questionIndex: currentIndex)
                returnAnswerButtonsToUnselectedState()
                addVideoView()
            }
            
            // Make sure selection warning label is not visible
            selectionWarningLabel.alpha = 0
        } else {
            selectionWarningLabel.alpha = 1
        }
    }
    
    private func setQuestionText(questionIndex: Int) {
        questionLabel.text = assessmentViewModel.getQuestionText(questionIndex: currentIndex)
        self.setButtons(questionIndex: currentIndex)
    }
    
    private func returnAnswerButtonsToUnselectedState() {
        for view in answerButtonsStackView.subviews {
            if let button = view as? DefaultButton {
                if button.isSelected {
                    button.backgroundColor = Colours.secondaryLight
                    button.setTitleColor(Colours.primaryDark, for: .normal)
                    button.isSelected = !button.isSelected
                }
            }
        }
    }
    
    private func addVideoView() {
        
        self.addChild(playerViewController)
        videoContainerView.addSubview(playerViewController.view)
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerViewController.view.centerXAnchor.constraint(equalTo: videoContainerView.centerXAnchor),
            playerViewController.view.centerYAnchor.constraint(equalTo: videoContainerView.centerYAnchor),
            playerViewController.view.widthAnchor.constraint(equalTo: videoContainerView.widthAnchor),
            playerViewController.view.heightAnchor.constraint(equalTo: videoContainerView.heightAnchor)
        ])
        playerViewController.didMove(toParent: self)
        
        if let playerItem = assessmentViewModel.getPlayerItem(currentIndex: currentIndex) {
            playerViewController.player = AVPlayer(playerItem: playerItem)
        }
    }
    
    private func isAnswerSelected() -> Bool {
        for (_, view) in answerButtonsStackView.subviews.enumerated() {
            if let button = view as? DefaultButton {
                if button.isSelected {
                    return true
                }
            }
        }
        return false
    }
    
    func setButtons(questionIndex: Int) {
        
        let buttonLabels = assessmentViewModel.getAnswers(questionIndex: currentIndex)
        
        if buttonLabels.count < 3 {
            if let view = answerButtonsStackView.arrangedSubviews.first {
                view.isHidden = true
            }
            (answerButtonsStackView.arrangedSubviews[1] as! DefaultButton).setTitle("No", for: .normal)
            (answerButtonsStackView.arrangedSubviews[2] as! DefaultButton).setTitle("Yes", for: .normal)
        } else {
            if let view = answerButtonsStackView.arrangedSubviews.first {
                view.isHidden = false
            }
            answerButtonsStackView.arrangedSubviews.enumerated().forEach{ (idx, element) in (element as! DefaultButton).setTitle(buttonLabels[idx], for: .normal)}
        }
    }
    
    func prepareForPlayback() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            print(error)
        }
    }
    
}

