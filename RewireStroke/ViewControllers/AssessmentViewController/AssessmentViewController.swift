//
//  AssessmentViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 18/02/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit
import FirebaseStorage
import AVKit
import HCVimeoVideoExtractor

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
    var playerLayer: AVPlayerLayer!
    var backgroundPlayerLayer: CALayer!
    var backgroundView: UIView!
    var backgroundButton: UIButton!
    
    // MARK: - Outlets
    @IBOutlet weak var warningLabel: WarningLabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var selectionWarningLabel: BorderlessWarningLabel!
    @IBOutlet weak var assessmentLabel: UILabel!
    
    @IBOutlet weak var answerButtonsStackView: UIStackView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var videoContainerView: UIView!
    
    private var questions = [Question]()
    private var currentIndex: Int = 0
    var video: HCVimeoVideo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setQuestionText(questionIndex: currentIndex)
        setButtons(questionIndex: currentIndex)
        setUpButtonResponses()
        prepareForPlayback()
        addVideoView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            
            DispatchQueue.main.async {
                self.backgroundPlayerLayer = CALayer()
                self.backgroundPlayerLayer.backgroundColor = UIColor.white.cgColor
                self.backgroundPlayerLayer.opacity = 0.5
                self.backgroundPlayerLayer?.frame = self.view.frame
                self.backgroundPlayerLayer.frame.size.height = self.view.frame.width
                self.backgroundPlayerLayer.frame.size.width = self.view.frame.height

                self.backgroundButton = UIButton()
                self.backgroundButton.backgroundColor = UIColor.white
                self.backgroundButton?.frame = self.view.frame
                self.backgroundButton.frame.size.height = self.view.frame.width
                self.backgroundButton.frame.size.width = self.view.frame.height
                
                self.playerLayer = AVPlayerLayer(player: self.playerViewController.player)
                self.playerLayer?.frame = self.view.frame
                self.playerLayer.frame.size.height = self.view.frame.width
                self.playerLayer.frame.size.width = self.view.frame.height

                self.playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
                self.view.addSubview(self.backgroundButton)
                self.view.layer.addSublayer(self.playerLayer)
            
                self.backgroundButton.addTarget(self, action: #selector(self.pauseVideo), for: .touchUpInside)
            }
        } else if UIDevice.current.orientation.isPortrait || UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
            self.playerLayer?.removeFromSuperlayer()
            self.backgroundButton?.removeFromSuperview()
            self.backgroundPlayerLayer?.removeFromSuperlayer()
        }
    }

    private func setUpUI() {
        self.title = "Assessment"
        
        for view in answerButtonsStackView.subviews {
            if let button = view as? DefaultButton {
                button.backgroundColor = Colours.grey03
                button.titleLabel?.font = UIFont.outfitBold()
                button.setTitleColor(.white, for: .normal)
            }
        }
        
        warningLabel.text = "Please have someone else complete this assessment on your behalf. \n\nQuestions must be answered accurately to deliver appropriate content."

        warningLabel.font = UIFont.outfitRegular()
        questionLabel.font = UIFont.outfitRegular()
        selectionWarningLabel.font = UIFont.outfitRegular()
        assessmentLabel.font = UIFont.outfitRegular()
        
        assessmentLabel.textColor = Colours.primaryDark
        questionLabel.textColor = Colours.primaryDark
        
        // Make the selection warning label invisible initially
        selectionWarningLabel.alpha = 0
        
        nextButton.tintColor = Colours.primaryDark
        backButton.tintColor = Colours.primaryDark
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
            button.backgroundColor = Colours.grey03
            button.setTitleColor(.white, for: .normal)
            button.isSelected = !button.isSelected
            
        } else {

            returnAnswerButtonsToUnselectedState()
            button.isSelected = !button.isSelected
            button.backgroundColor = Colours.primaryDark
            button.setTitleColor(Colours.primaryDark, for: .normal)
            // Hacky
            if button.currentTitle == "Yes" || button.currentTitle == "Fully" {
                UserManager.LLAssessmentScore += 1
            }
            
        }
        
    }
    
    @objc private func backButtonTapped(_ button : DefaultButton) {
        guard currentIndex > 0 else { return }
        currentIndex-=1
        setQuestionText(questionIndex: currentIndex)
        setButtons(questionIndex: currentIndex)
        returnAnswerButtonsToUnselectedState()
    }
    
    @objc private func nextButtonTapped(_ button : DefaultButton) {
        
        // First, stop playing the current video!
        playerViewController.player?.pause()
    
        // Only move on if we have an answer selected 
        if isAnswerSelected() {
            
            // then we move on to next question
            currentIndex+=1
            
            if currentIndex >= assessmentViewModel.getNumberOfQuestions() {
                let popupViewController = SubmitPopUpViewController.init(nibName: Constants.View.submitPopUpViewController, bundle: nil)
                popupViewController.modalPresentationStyle = .popover
                popupViewController.finishedWorkoutDelegate = self
                popupViewController.activityViewModel = activityViewModel
                present(popupViewController, animated: true)
            } else {
                setQuestionText(questionIndex: currentIndex)
                setButtons(questionIndex: currentIndex)
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
    }
    
    private func returnAnswerButtonsToUnselectedState() {
        for view in answerButtonsStackView.subviews {
            if let button = view as? DefaultButton {
                if button.isSelected {
                    button.backgroundColor = Colours.grey03
                    button.setTitleColor(.white, for: .normal)
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
        
        //        if let playerItem = assessmentViewModel.getPlayerItem(currentIndex: currentIndex) {
        //            playerViewController.player = AVPlayer(playerItem: playerItem)
        //        }
        
        HCVimeoVideoExtractor.fetchVideoURLFrom(url: URL(string: assessmentViewModel.getVideoPath(questionIndex: self.currentIndex))!, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
            if let err = error {
                print("Error = \(err.localizedDescription)")
                return
            }
            
            guard let vid = video else {
                print("Invalid video object")
                return
            }
            
            DispatchQueue.main.async {
                self.playerViewController.player = AVPlayer(url: vid.videoURL[.Quality540p]!)
            }
            
        })

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
        // Hide the first button if we only have 2 answers!
        if buttonLabels.count == 2 {
            if let view = answerButtonsStackView.arrangedSubviews.last {
                view.isHidden = true
            }
        }
        
        buttonLabels.enumerated().forEach { (idx, element) in
            (answerButtonsStackView.arrangedSubviews[idx] as! DefaultButton).setTitle(element, for: .normal)
        }
    }
    
    func prepareForPlayback() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            print(error)
        }
    }
    
    @objc func pauseVideo() {
        let currentRate = playerViewController.player?.rate
        
        playerViewController.player?.rate = currentRate == 0.0 ? 1.0 : 0.0
        
        if currentRate == 0.0 {
            playerViewController.player?.play()
            DispatchQueue.main.async {
                self.backgroundPlayerLayer?.removeFromSuperlayer()
            }
            
        } else {
            DispatchQueue.main.async {
                self.view.layer.addSublayer(self.backgroundPlayerLayer)
            }
        }
        
    }
}

