//
//  Constants.swift
//  RewireStroke
//
//  Created by Amy Ha on 23/09/2020.
//  Copyright © 2020 Amy Ha. All rights reserved.
//

import UIKit

struct Constants {
    
    struct Font {
        
        struct Name {
            static let robotoLight = "Roboto-Light"
            static let robotoRegular = "Roboto-Regular"
            static let robotoMedium = "Roboto-Medium"
            static let robotoBold = "Roboto-Bold"
            
            static let rajdhaniSemiBold = "Rajdhani-SemiBold"
            
            static let outfitBold = "Outfit-Bold"
            static let outfitRegular = "Outfit-Regular"
        }
        
        struct Size {
            
            // Default sizes across the app
            static let small = CGFloat(14)
            static let standard = CGFloat(17)
            static let large = CGFloat(30)
            static let xLarge = CGFloat(40)
            static let xxLarge = CGFloat(48)
            
            // Less commonly used sizes
            static let hintButton = CGFloat(16)
        }
    }
    
    struct View {
        static let welcomeViewController = "WelcomeViewController"
        static let homeViewController = "HomeViewController"
        static let assessmentViewController = "AssessmentViewController"
        static let submitPopUpViewController = "SubmitPopUpViewController"
        static let activityViewController = "ActivityViewController"
        static let progressViewController = "ProgressViewController"
        static let workoutViewController = "WorkoutViewController"
        static let startWorkoutViewController = "StartWorkoutViewController"
        static let infoViewController = "InfoViewController"
        static let profileViewController = "ProfileViewController"
    }
}
