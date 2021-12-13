//
//  Question.swift
//  RewireStroke
//
//  Created by Amy Ha on 20/02/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

enum ActivityType: String {
    case lowerLimb = "Lower limb"
    case upperLimb = "Upper Limb"
    case balance = "Balance"
}


struct Question {
    var questionText: String
    var activityType: ActivityType
    var answers = ["Not at all", "A little", "Fully"]
    var videoPath: String
}
