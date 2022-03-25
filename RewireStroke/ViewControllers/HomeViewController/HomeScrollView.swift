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
                SelectActivityView(function: "Upper Limb", score: 0, icon: "iconUpperLimb", colour: Colours.primaryUpperLimbColor, activityViewModel: activityViewModel)
                
                SelectActivityView(function: "Lower Limb", score: 0, icon: "iconLowerLimb", colour: Colours.primaryLowerLimbColor, activityViewModel: activityViewModel)
                
                SelectActivityView(function: "Balance", score: 0, icon: "iconBalance", colour: Colours.primaryBalanceColor, activityViewModel: activityViewModel)
            }.navigationTitle(Text("Select an Activity"))
                .offset(y: -90)
        }.frame(minHeight: minRowHeight * 18).font(Font.robotoBold(size: 20.0)).foregroundColor(.black)
    }
}

struct SelectActivityView: View {
    
    var function: String
    var score: Int
    var icon: String
    var colour: Color
    var activityViewModel: ActivityViewModel
    @State private var isWorkoutDisplayed = false
    
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
                    Image("iconRightArrow").frame(width:100, alignment: .leading)
                    Text(String(score)).font(.outfitRegular(size: 32.0)).foregroundColor(colour)
                }
                RoundedRectangle(cornerRadius: 35, style: .continuous).fill(Colours.grey02Color).frame(height: 20)
            }.frame(width: 300)
            
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
