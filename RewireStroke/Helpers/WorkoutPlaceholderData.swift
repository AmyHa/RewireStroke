//
//  Data.swift
//  RewireStroke
//
//  Created by Amy Ha on 14/08/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import Foundation

struct WorkoutPlaceholderData {
    
    private static var allInstances = 0
    private let instance: Int
    
    var ULworkouts: [Workout]!
    var BAWorkouts: [Workout]!
    
    // Workouts
    var LL_LittleWorkoutA: Workout!
    var LL_LittleWorkoutB: Workout!
    var LL_Fully: Workout!
    var LL_PreassessmentPlaceholder: Workout!
    var LL_QuickQuadsWorkout: Workout!
        
    var UL_PreassessmentPlaceholder: Workout!
    
    var BA_BodyScanWorkout: Workout!
    var BA_ProprioceptionGame: Workout!
    var BA_HipBalance: Workout!
    
    var PreassessmentUnlock: Workout!
    
    init() {
        WorkoutPlaceholderData.allInstances += 1
        instance = WorkoutPlaceholderData.allInstances
        print("WorkoutPlaceholderData.init() #\(instance)")
        
        let kneeExtension = Exercise(name: "Knee Extension", activityType: .lowerLimb, ability: .fully, image: "little-knee-extension", videoPath: "https://vimeo.com/693645125")
        let kneeFlexion = Exercise(name: "Knee Flexion", activityType: .lowerLimb, ability: .little, image: "little-knee-flexion", videoPath: "https://vimeo.com/693645204")
        let quadActivation = Exercise(name: "Quad Activation", activityType: .lowerLimb, ability: .little, image: "little-quad-activation", videoPath: "https://vimeo.com/693645659")
        let hamstringActivation = Exercise(name: "Hamstring Activation", activityType: .lowerLimb, ability: .little, image: "little-hamstring-activation", videoPath: "https://vimeo.com/693642909")
        let ankleDorsiflexion = Exercise(name: "Ankle Dorsiflexion", activityType: .lowerLimb, ability: .little, image: "little-ankle-dorsiflexion", videoPath: "https://vimeo.com/693642334")
        let anklePlantarflexion = Exercise(name: "Ankle Plantarflexion", activityType: .lowerLimb, ability: .little, image: "little-ankle-plantarflexion", videoPath: "https://vimeo.com/692145096")
        let quadContraction = Exercise(name: "Quad Contraction", activityType: .lowerLimb, ability: .little, image: "little-quad-contraction", videoPath: "https://vimeo.com/693645819")

        let fullyToeRaises = Exercise(name: "Toe Raises", activityType: .lowerLimb, ability: .fully, image: "fully-toe-raises", videoPath: "https://vimeo.com/693714418")
        let fullyHeelRaises = Exercise(name: "Heel Raises", activityType: .lowerLimb, ability: .fully, image: "fully-heel-raises", videoPath: "https://vimeo.com/693713788")
        let fullyKneeExtension = Exercise(name: "Knee Extension", activityType: .lowerLimb, ability: .fully, image: "fully-knee-extension", videoPath: "https://vimeo.com/693714138")
        let fullySquats = Exercise(name: "Squats", activityType: .lowerLimb, ability: .fully, image: "fully-squats", videoPath: "https://vimeo.com/693714328")
        let fullySplitStanding = Exercise(name: "Split Standing", activityType: .lowerLimb, ability: .fully, image: "fully-split-standing", videoPath: "https://vimeo.com/693713618")
        let fullyHipPush = Exercise(name: "Hip Push", activityType: .lowerLimb, ability: .fully, image: "fully-hip-push", videoPath: "https://vimeo.com/693713938")
        
        let LL_ExerciseArrayA = [kneeExtension, kneeFlexion, quadActivation, hamstringActivation, ankleDorsiflexion, anklePlantarflexion]
        
        let LL_ExerciseArrayB = [kneeExtension, kneeFlexion, quadContraction, ankleDorsiflexion, anklePlantarflexion]
        
        let LL_FullyExerciseArray = [fullyKneeExtension, fullyHeelRaises, fullyToeRaises, fullySquats, fullySplitStanding, fullyHipPush]
        
        LL_LittleWorkoutA = Workout(name: "Leg Strength A", exercises: LL_ExerciseArrayA, activityType: .lowerLimb, image: "LL_LegStrengthWorkoutAThumbnail")
        LL_LittleWorkoutB = Workout(name: "Leg strength B", exercises: LL_ExerciseArrayB, activityType: .lowerLimb, image: "LL_LegStrengthWorkoutBThumbnail")
        
        LL_QuickQuadsWorkout = Workout(name: "Quick Quads", exercises: [Exercise](), activityType: .lowerLimb, image: "LLEnduranceWorkoutThumbnail")
        
        LL_Fully = Workout(name: "Fully Workout", exercises: LL_FullyExerciseArray, activityType: .lowerLimb, image: "LL_LegStrengthWorkoutAThumbnail")
        
        LL_PreassessmentPlaceholder = Workout(name: "Assessment", exercises: [Exercise](), activityType: .lowerLimb, image: "LLPreassessmentCard")
        
        UL_PreassessmentPlaceholder = Workout(name: "Assessment", exercises: [Exercise](), activityType: .lowerLimb, image: "ULAssessmentThumbnail")
        PreassessmentUnlock = Workout( name: "", exercises: [Exercise](), activityType: .lowerLimb, image: "UnlockAssessment")
        
        BA_BodyScanWorkout = Workout(name: "Body scan", exercises: [Exercise](), activityType: .lowerLimb, image: "BalanceBodyScanThumbnail")
        BA_ProprioceptionGame = Workout(name: "Proprioception game", exercises: [Exercise](), activityType: .lowerLimb, image: "BalanceProprioceptionGameThumbnail")
        
        BA_HipBalance = Workout(name: "Hip Balance", exercises: [Exercise](), activityType: .lowerLimb, image: "BAHipBalanceThumbnail")
        
        ULworkouts = [UL_PreassessmentPlaceholder]
        BAWorkouts = [BA_BodyScanWorkout, BA_ProprioceptionGame, BA_HipBalance]
    }
}
