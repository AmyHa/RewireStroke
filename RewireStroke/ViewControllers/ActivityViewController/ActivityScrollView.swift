//
//  ActivityScrollView.swift
//  RewireStroke
//
//  Created by Amy Ha on 12/03/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import SwiftUI
import UIKit

//
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
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Colours.primaryDark, .font: UIFont.outfitSemiBold(size: 32)]
        self.activityViewModel = activityViewModel
    }

    var body: some View {
        
            NavigationView {
                
                if #available(iOS 15.0, *) {
                    ScrollView {
                        AssessmentScrollView(titleFontColor: Colours.primaryUpperLimbColor, activityType: .upperLimb, imageName: "workoutBannerUpperLimb")
//                        WorkoutsScrollView(activityViewModel: activityViewModel, workouts: activityViewModel.ULworkouts, titleFontColor: Colours.primaryUpperLimbColor, activityType: .upperLimb)
                        WorkoutsScrollView(activityViewModel: activityViewModel, workouts: activityViewModel.LLworkouts.value, titleFontColor: Colours.primaryLowerLimbColor, activityType: .lowerLimb)
                        WorkoutsScrollView(activityViewModel: activityViewModel, workouts: activityViewModel.BAWorkouts, titleFontColor: Colours.primaryBalanceColor, activityType: .balance)
                    }.navigationBarTitle("Activity").background(.white).frame(width: 350)
                } else {
                    // Fallback on earlier versions
                }
                
            }.frame(minHeight: minRowHeight * 18)
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
                .scaledToFill()
                .frame(width: 150, height: 120, alignment: .leading)
                .cornerRadius(5.0)
            Spacer()
            Spacer()
        }.padding(.trailing, 5)
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
                Text(activityType.rawValue).font(Font.outfitBold(size: 16)).foregroundColor(titleFontColor)
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

struct AssessmentScrollView: View {
    
    var titleFontColor: Color
    var activityType: ActivityType
    var imageName: String
    @State private var isWorkoutDisplayed = false

    var body: some View {
        if #available(iOS 14.0, *) {
            VStack(alignment: .leading) {
                Text(activityType.rawValue).font(Font.outfitBold(size: 16)).foregroundColor(titleFontColor)
                ScrollView(.horizontal) {
                    
                    VStack (alignment: .leading) {
                        
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350, height: 180, alignment: .leading)
                            .cornerRadius(5.0)
                        Spacer()
                        Spacer()
                    }.padding(.trailing, 5)
                    .onTapGesture {
                        isWorkoutDisplayed = true
                    }
                    .sheet(isPresented: $isWorkoutDisplayed, onDismiss: {
                    }, content: {
                        DummyAssessmentView()
                    })
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct DummyAssessmentView: View {
    var body: some View {
        Text("Content to be added soon!")
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
