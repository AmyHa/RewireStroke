//
//  ActivityViewModel.swift
//  RewireStroke
//
//  Created by Amy Ha on 09/06/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import Foundation
import Combine

class ActivityViewModel: ObservableObject {
    
    private static var allInstances = 0
    private let instance: Int
    var LLworkouts = CurrentValueSubject<[Workout], Never>([])
    
    var ULworkouts: [Workout]!
    var BAWorkouts: [Workout]!
    
    var addNewWorkout = PassthroughSubject<[Workout], Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    var data: WorkoutPlaceholderData!
    
    deinit {
        print("ActivityViewModel.deinit() #\(instance)")
    }
    
    init(data: WorkoutPlaceholderData) {
        ActivityViewModel.allInstances += 1
        instance = ActivityViewModel.allInstances
        
        // might not need the below
        self.ULworkouts = data.ULworkouts
        self.BAWorkouts = data.BAWorkouts
        
        print("ActivityViewModel.init() #\(instance)")
        
        addNewWorkout
            .sink { _ in
                
            } receiveValue: { (newWorkout) in
                print("send the new workout" + newWorkout.description)
                self.LLworkouts.send(newWorkout)
            }.store(in: &subscriptions)
        
        LLworkouts.sink { [unowned self] (values) in
            print("tasks were updated to \(values)")
            print("The new LL workouts are " + LLworkouts.value.description)
            self.objectWillChange.send()
        }.store(in: &subscriptions)
        
        self.data = data
        setupAssessment()
    }

    func setupAssessment() {
        print("set up assessment called")
        self.addNewWorkout.send([data.LL_PreassessmentPlaceholder, data.PreassessmentUnlock])
    }
    
    func setUpLLWorkout() {
        if UserManager.LLAssessmentScore < 5 {
            self.addNewWorkout.send([data.LL_LittleWorkout1, data.LL_LittleWorkout2, data.LL_ImprovingFlexibility, data.LL_EnduranceWorkout])
        } else {
            self.addNewWorkout.send([data.LL_Fully])
        }
    }
}

