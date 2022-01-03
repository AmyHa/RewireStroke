//
//  ActivityScrollView.swift
//  RewireStroke
//
//  Created by Amy Ha on 12/03/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import SwiftUI
import UIKit


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityScrollView(lowerLimbWorkouts)
//    }
//}

struct ActivityScrollView: View {
    
    @ObservedObject var activityViewModel: ActivityViewModel
    
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    
    init(_ activityViewModel: ActivityViewModel) {
        
        //Use this if NavigationBarTitle is with Large Font
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Colours.primaryBlue, .font: UIFont.robotoMedium(size: 32)]
        self.activityViewModel = activityViewModel
    }

    var body: some View {
        
        VStack{
            NavigationView {
                
                List {
                    WorkoutsScrollView(activityViewModel: activityViewModel, workouts: activityViewModel.ULworkouts, titleFontColor: Colours.primaryUpperLimbColor, activityType: .upperLimb)
                    WorkoutsScrollView(activityViewModel: activityViewModel, workouts: activityViewModel.LLworkouts.value, titleFontColor: Colours.primaryLowerLimbColor, activityType: .lowerLimb)
                    WorkoutsScrollView(activityViewModel: activityViewModel, workouts: activityViewModel.BAWorkouts, titleFontColor: Colours.primaryBalanceColor, activityType: .balance)
                }.navigationBarTitle("Activity")
                
            }.frame(minHeight: minRowHeight * 20).font(Font.robotoBold(size: 20.0)).foregroundColor(.black)
        }
    }
}

@available(iOS 14.0, *)
struct WorkoutView: View {
    @ObservedObject var activityViewModel: ActivityViewModel
    @State private var isWorkoutDisplayed = false

    var workout: Workout
    var body: some View {
        VStack (alignment: .leading) {
            
            Image(workout.image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 100)
                .cornerRadius(5.0)
            Text(workout.name).lineLimit(nil).font(Font.robotoRegular(size: 14.0)).foregroundColor(Colours.primaryDarkColor)
        }.padding(.trailing, 25)
        .onTapGesture {
            isWorkoutDisplayed = true
        }
        .sheet(isPresented: $isWorkoutDisplayed, onDismiss: {
            print("the new workouts are... \(activityViewModel.LLworkouts.value)")
        }, content: {
            // Placeholder code – only show the workouts if there are exercises
            if workout.name == "Assessment" {
                AssessmentPageView(activityViewModel: activityViewModel)
            } else  {
                WorkoutPageView(workout: workout)
            }
        })
    }
}

struct WorkoutsScrollView: View {
    @ObservedObject var activityViewModel: ActivityViewModel
    var workouts: [Workout]
    var titleFontColor: Color
    var activityType: ActivityType
    
    var body: some View {
        if #available(iOS 14.0, *) {
            VStack(alignment: .leading) {
                Text(activityType.rawValue).font(Font.robotoMedium(size: 20)).foregroundColor(titleFontColor)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(workouts) { workout in
                            WorkoutView(activityViewModel: activityViewModel, workout: workout)
                        }
                    }
                }
            }.padding(.top,20)
        } else {
            // Fallback on earlier versions
        }
    }
}


struct WorkoutPageView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode

    var workout: Workout

    func makeUIViewController(context: Context) -> WorkoutViewController {
        return WorkoutViewController(workout: workout)
    }

    func updateUIViewController(_ uiViewController: WorkoutViewController, context: Context) {

    }

    typealias UIViewControllerType = WorkoutViewController

}


struct AssessmentPageView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activityViewModel: ActivityViewModel
    
    func makeUIViewController(context: Context) -> AssessmentViewController {
        return AssessmentViewController(activityViewModel: activityViewModel)
    }

    func updateUIViewController(_ uiViewController: AssessmentViewController, context: Context) {

    }

    typealias UIViewControllerType = AssessmentViewController

}
