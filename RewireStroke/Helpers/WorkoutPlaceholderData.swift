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
    var LL_LittleWorkout1: Workout!
    var LL_LittleWorkout2: Workout!
    var LL_Fully: Workout!
    var LL_PreassessmentPlaceholder: Workout!
    var LL_ImprovingFlexibility: Workout!
    var LL_EnduranceWorkout: Workout!
        
    var UL_PreassessmentPlaceholder: Workout!
    
    var BA_BodyScanWorkout: Workout!
    var BA_ProprioceptionGame: Workout!
    var BA_HipBalance: Workout!
    var BA_StandingBalance: Workout!
    
    var PreassessmentUnlock: Workout!
    
    init() {
        WorkoutPlaceholderData.allInstances += 1
        instance = WorkoutPlaceholderData.allInstances
        print("WorkoutPlaceholderData.init() #\(instance)")
        
        let kneeExtension = Exercise(name: "Knee Extension", activityType: .lowerLimb, ability: .fully, image: "little-knee-extension", videoPath: "little-knee-extension.mp4")
        let kneeFlexion = Exercise(name: "Knee Flexion", activityType: .lowerLimb, ability: .little, image: "little-knee-flexion", videoPath: "little-knee-flexion.mp4")
        let quadActivation = Exercise(name: "Quad Activation", activityType: .lowerLimb, ability: .little, image: "little-quad-activation", videoPath: "little-quad-activation.mp4")
        let hamstringActivation = Exercise(name: "Hamstring Activation", activityType: .lowerLimb, ability: .little, image: "little-hamstring-activation", videoPath: "little-hamstring-activation.mp4")
        let ankleDorsiflexion = Exercise(name: "Ankle Dorsiflexion", activityType: .lowerLimb, ability: .little, image: "little-ankle-dorsiflexion", videoPath: "little-ankle-dorsiflexion.mp4")
        let anklePlantarflexion = Exercise(name: "Ankle Plantarflexion", activityType: .lowerLimb, ability: .little, image: "little-ankle-plantarflexion", videoPath: "little-ankle-plantarflexion.mp4")
        let quadContraction = Exercise(name: "Quad Contraction", activityType: .lowerLimb, ability: .little, image: "little-quad-contraction", videoPath: "little-quad-contraction.mp4")

//        let standingTolerance = Exercise(name: "Standing Tolerance", activityType: .lowerLimb, ability: .little, image: "little-standing-tolerance", videoPath: "little-standing-tolerance.mp4")
//        let supportedKneeFlexion = Exercise(name: "Supported Knee Flexion", activityType: .lowerLimb, ability: .little, image: "little-supported-knee-flexion", videoPath: "little-supported-knee-flexion.mp4")
        
        let fullyToeRaises = Exercise(name: "Toe Raises", activityType: .lowerLimb, ability: .fully, image: "fully-toe-raises", videoPath: "fully-toe-raises.mp4")
        let fullyHeelRaises = Exercise(name: "Heel Raises", activityType: .lowerLimb, ability: .fully, image: "fully-heel-raises", videoPath: "fully-heel-raises.mp4")
        let fullyKneeExtension = Exercise(name: "Knee Extension", activityType: .lowerLimb, ability: .fully, image: "fully-knee-extension", videoPath: "fully-knee-extension.mp4")
        let fullySquats = Exercise(name: "Squats", activityType: .lowerLimb, ability: .fully, image: "fully-squats", videoPath: "fully-squats.mp4")
        let fullySplitStanding = Exercise(name: "Split Standing", activityType: .lowerLimb, ability: .fully, image: "fully-split-standing", videoPath: "fully-split-standing.mp4")
        let fullyHipPush = Exercise(name: "Hip Push", activityType: .lowerLimb, ability: .fully, image: "fully-hip-push", videoPath: "fully-hip-push.mp4")
        
        let LL_ExerciseArrayA = [kneeExtension, kneeFlexion, quadActivation, hamstringActivation, ankleDorsiflexion, anklePlantarflexion]
        
        let LL_ExerciseArrayB = [kneeFlexion, kneeExtension, quadContraction, ankleDorsiflexion, anklePlantarflexion]
        
        let LL_FullyExerciseArray = [fullyKneeExtension, fullyHeelRaises, fullyToeRaises, fullySquats, fullySplitStanding, fullyHipPush]
        
        LL_LittleWorkout1 = Workout(name: "Leg strength part 1", exercises: LL_ExerciseArrayA, activityType: .lowerLimb, image: "LLWorkout1Thumbnail")
        LL_LittleWorkout2 = Workout(name: "Leg strength part 2", exercises: LL_ExerciseArrayB, activityType: .lowerLimb, image: "LLWorkout2Thumbnail")
        
        LL_ImprovingFlexibility = Workout(name: "Improving Flexibility", exercises: [Exercise](), activityType: .lowerLimb, image: "LLImprovingFlexibilityThumbnail")
        LL_EnduranceWorkout = Workout(name: "Endurance Workout", exercises: [Exercise](), activityType: .lowerLimb, image: "LLEnduranceWorkoutThumbnail")
        
        LL_Fully = Workout(name: "Fully Workout", exercises: LL_FullyExerciseArray, activityType: .lowerLimb, image: "LLWorkout1Thumbnail")
        LL_PreassessmentPlaceholder = Workout(name: "Assessment", exercises: [Exercise](), activityType: .lowerLimb, image: "LLWorkout1Thumbnail")
        
        UL_PreassessmentPlaceholder = Workout(name: "Assessment", exercises: [Exercise](), activityType: .lowerLimb, image: "ULAssessmentThumbnail")
        PreassessmentUnlock = Workout( name: "", exercises: [Exercise](), activityType: .lowerLimb, image: "UnlockAssessment")
        
        BA_BodyScanWorkout = Workout(name: "Body scan", exercises: [Exercise](), activityType: .lowerLimb, image: "BalanceBodyScanThumbnail")
        BA_ProprioceptionGame = Workout(name: "Proprioception game", exercises: [Exercise](), activityType: .lowerLimb, image: "BalanceProprioceptionGameThumbnail")
        
        BA_HipBalance = Workout(name: "Hip Balance", exercises: [Exercise](), activityType: .lowerLimb, image: "BAHipBalanceThumbnail")
        BA_StandingBalance = Workout(name: "Standing Balance", exercises: [Exercise](), activityType: .lowerLimb, image: "BAStandingBalanceThumbnail")
        
        ULworkouts = [UL_PreassessmentPlaceholder]
        BAWorkouts = [BA_BodyScanWorkout, BA_ProprioceptionGame, BA_HipBalance, BA_StandingBalance]
    }
}
