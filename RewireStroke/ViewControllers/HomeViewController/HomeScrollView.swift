//
//  HomeScrollView.swift
//  RewireStroke
//
//  Created by Amy Ha on 12/03/2022.
//  Copyright © 2022 Amy Ha. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScrollView()
    }
}

struct HomeScrollView: View {
    
//    @ObservedObject var activityViewModel: ActivityViewModel
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    
    var data: WorkoutPlaceholderData!
    var activityViewModel: ActivityViewModel!
    
    init() {

        data = WorkoutPlaceholderData()
        activityViewModel = ActivityViewModel(data: data)
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Colours.primaryDark, .font: UIFont.outfitSemiBold(size: 32)]

    }
    
    var body: some View {
        
        NavigationView{
            VStack {
                SelectActivityView(function: "Upper Limb", score: "Assess", icon: "iconUpperLimb", colour: Colours.primaryUpperLimbColor, completedWorkouts: 0, activityViewModel: activityViewModel)
                
                SelectActivityView(function: "Lower Limb", score: "0/3", icon: "iconLowerLimb", colour: Colours.primaryLowerLimbColor, completedWorkouts: 0, activityViewModel: activityViewModel)
                
                SelectActivityView(function: "Balance", score: "0/3", icon: "iconBalance", colour: Colours.primaryBalanceColor, completedWorkouts: 1, activityViewModel: activityViewModel)
            }.navigationTitle(Text("Weekly Goals"))
                .offset(y: -90)
        }.frame(minHeight: minRowHeight*18)
    }
}

struct SelectActivityView: View {
    
    var function: String
    var score: String
    var icon: String
    var colour: Color
    var completedWorkouts: Int
    var activityViewModel: ActivityViewModel
    
    @State private var isWorkoutDisplayed = false
    @State private var maxProgressLength: CGFloat = 300
    @State private var progress: CGFloat = 0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous).fill(Colours.grey01Color).frame(width: 350, height: 150)
            VStack {
                HStack() {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .clipped().frame(width: 40, height: 60)
                    Text(function).font(.outfitRegular(size: 22.0)).foregroundColor(Colours.primaryDarkColor).frame(maxWidth: .infinity, alignment: .leading)
                    Image("iconRightArrow").frame(width:20, alignment: .leading)
                    Text(score).font(.outfitMedium(size: 20)).foregroundColor(colour).frame(width: 80)
                }
                ZStack(alignment: .leading, content: {
                    RoundedRectangle(cornerRadius: 35, style: .continuous).fill(Colours.grey02Color).frame(height: 20)
                    RoundedRectangle(cornerRadius: 35, style: .continuous).fill(LinearGradient(gradient: Gradient(colors: [Colours.grey01Color, colour]), startPoint: .leading, endPoint: .trailing)).frame(width: (CGFloat(completedWorkouts)/3)*maxProgressLength, height: 20)
                })
            }.frame(width: maxProgressLength)
            
        }

        .onTapGesture {
            isWorkoutDisplayed = true
        }
        .sheet(isPresented: $isWorkoutDisplayed, onDismiss: {
            print("the new workouts are... \(activityViewModel.LLworkouts.value)")
        }, content: {
            WorkoutPageView(workout: activityViewModel.LLworkouts.value[0])
        })
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
}
