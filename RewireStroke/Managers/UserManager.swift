//
//  UserManager.swift
//  RewireStroke
//
//  Created by Amy Ha on 20/03/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class UserManager {
    
    var subscriptions = Set<AnyCancellable>()
    
    static var uid = ""
    static var numberOfLogins = 1
    
    static var LLAssessmentScore = 0
    static var ULAssessmentScore = 0
    static var BalanceAssessmentScore = 0
    
    static var completedLLAssessment = false
    static var completedULAssessment = false
    static var completedBalanceAssessment = false
    
    static var completedLLWorkouts = 0
    static var completedULWorkouts = 0
    static var completedBalanceWorkouts = 0
}
