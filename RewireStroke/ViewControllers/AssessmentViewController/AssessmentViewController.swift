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
        self.setUpQuestions()
        self.setUpButtonResponses()
        self.prepareForPlayback()
        
        playEmbedInVideo()
   }

    private func setUpQuestions() {
        
        let question1 = Question(questionText: "Can your dad lift his foot up whilst keeping his heel on the ground?", activityType: .lowerLimb,  videoPath: "assess-forefoot-lift.mp4")
        let question2 = Question(questionText: "Can your dad tense his thigh?", activityType: .lowerLimb,  videoPath: "assess-isometric-knee-contraction.mp4")
        let question3 = Question(questionText: "Can your dad extend his knee?", activityType: .lowerLimb, videoPath: "assess-knee-extension.mp4")
        let question4 = Question(questionText: "Can you dad move from sitting to standing?", activityType: .lowerLimb, answers: ["No", "Yes"], videoPath: "assess-sit-to-stand.mp4")
        let question5 = Question(questionText: "Can your dad stand on his own for at least 2 minutes?", activityType: .lowerLimb, answers: ["No", "Yes"], videoPath: "assess-standing-for-two-minutes.mp4")
        
        
        self.questions.append(question1)
        self.questions.append(question2)
        self.questions.append(question3)
        self.questions.append(question4)
        self.questions.append(question5)
        
        // Set current question to first question
        setQuestionText(questionIndex: currentIndex)
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
    
        // Only move on if we have an answer selected
        if isAnswerSelected() {
            
            // then we move on to next question
            currentIndex+=1
            setQuestionText(questionIndex: currentIndex)
            
            // Make sure selection warning label is not visible
            selectionWarningLabel.alpha = 0
            
            // Don't play video if we're at the end of our survey
            if currentIndex >= questions.count || currentIndex < 0 {
                //creating a reference for the dialogView controller
                let popupViewController = SubmitPopUpViewController.init(nibName: Constants.View.submitPopUpViewController, bundle: nil)
                popupViewController.modalPresentationStyle = .popover
                popupViewController.finishedWorkoutDelegate = self
                popupViewController.activityViewModel = activityViewModel
                //presenting the pop up viewController from the parent viewController
                present(popupViewController, animated: true)
                
            } else {
                // return all buttons to unselected state
                returnAnswerButtonsToUnselectedState()
                
                playEmbedInVideo()
            }
        } else {
            selectionWarningLabel.alpha = 1
        }
    }
    
    private func setQuestionText(questionIndex: Int) {
        
        // If we've reached the end of the survey...
        if questionIndex >= questions.count || questionIndex < 0 {
            return
        } else {
            questionLabel.text = "\(questionIndex+1). \(questions[questionIndex].questionText)"
            if questions[currentIndex].answers.count < 3 {
                if let view = answerButtonsStackView.arrangedSubviews.first {
                    view.isHidden = true
                }
                
                // Then change the second and third button to show "No" and "Yes"
                (answerButtonsStackView.arrangedSubviews[1] as! DefaultButton).setTitle("No", for: .normal)
                (answerButtonsStackView.arrangedSubviews[2] as! DefaultButton).setTitle("Yes", for: .normal) 
            }
        }
            
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
    
    private func playEmbedInVideo() {
        
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
        
//        let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
        let documentsDirectory = CacheManager.getDocumentsDirectory()
        let currentVideoPath = questions[currentIndex].videoPath
        let destinationURL = documentsDirectory.appendingPathComponent(currentVideoPath)
        
        // Check if it exissts before downloading
        if FileManager.default.fileExists(atPath: destinationURL.path) {
            let playerItem = AVPlayerItem(url: destinationURL)
            playerViewController.player = AVPlayer(playerItem: playerItem)
            playerViewController.player?.play()
        } else {
            print("it doesn't exist!")
        }
    }
    
    private func isAnswerSelected() -> Bool {
        for (index, view) in answerButtonsStackView.subviews.enumerated() {
            if let button = view as? DefaultButton {
                if button.isSelected {
                    // If fully is selected...
                    if index == 2 {
                        UserManager.LLAssessmentScore = UserManager.LLAssessmentScore + 1;
                    }
                    
                    return true
                }
            }
        }
        return false
    }
    
    func prepareForPlayback() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            print(error)
        }
    }
    
}

