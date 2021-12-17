//
//  AssessmentViewModel.swift
//  RewireStroke
//
//  Created by Amy Ha on 14/12/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import Foundation
import AVKit

class AssessmentViewModel {
    
    private var questions = [Question]()
    private var currentIndex: Int = 0
    
    init() {
        self.setUpQuestions()
    }
    
    private func setUpQuestions() {
        // Questions are set up in the view model for now... but realistically will be taken from the backend
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
    }
    
    func getQuestionText(questionIndex: Int) -> String {
        return questions[questionIndex].questionText
    }
    
    func getAnswers(questionIndex: Int) -> [String] {
        return questions[questionIndex].answers
    }
    
    func getPlayerItem(currentIndex: Int) -> AVPlayerItem? {
        let documentsDirectory = CacheManager.getDocumentsDirectory()
        let currentVideoPath = questions[currentIndex].videoPath
        let destinationURL = documentsDirectory.appendingPathComponent(currentVideoPath)
        
        return FileManager.default.fileExists(atPath: destinationURL.path) ? AVPlayerItem(url: destinationURL) : nil
    }
    
    func getNumberOfQuestions() -> Int {
        return questions.count
    }

}
