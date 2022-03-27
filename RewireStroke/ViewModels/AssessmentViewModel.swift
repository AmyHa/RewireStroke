//
//  AssessmentViewModel.swift
//  RewireStroke
//
//  Created by Amy Ha on 14/12/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import Foundation
import AVKit
import HCVimeoVideoExtractor

class AssessmentViewModel {
    
    private var questions = [Question]()
    private var currentIndex: Int = 0
    
    init() {
        self.setUpQuestions()
    }
    
    private func setUpQuestions() {
        // Questions are set up in the view model for now... but realistically will be taken from the backend
        let question1 = Question(questionText: "1. Can you lift your foot off the ground?", activityType: .lowerLimb,  videoPath: "https://vimeo.com/691352036")
        let question2 = Question(questionText: "2. Can you tense your thigh?", activityType: .lowerLimb,  videoPath: "https://vimeo.com/691352036")
        let question3 = Question(questionText: "3. Can you extend your knee?", activityType: .lowerLimb, videoPath: "https://vimeo.com/691352036")
        let question4 = Question(questionText: "4. Can you move from sitting to standing?", activityType: .lowerLimb, answers: ["No", "Yes"], videoPath: "https://vimeo.com/691352036")
        let question5 = Question(questionText: "5. Can you stand independently for 2 minutes?", activityType: .lowerLimb, answers: ["No", "Yes"], videoPath: "https://vimeo.com/691352036")
        
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
    
    func getVideoPath(questionIndex: Int) -> String {
        return questions[currentIndex].videoPath
    }

}
