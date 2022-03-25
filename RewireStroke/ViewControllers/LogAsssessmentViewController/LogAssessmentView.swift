//
//  LogAssessmentView.swift
//  RewireStroke
//
//  Created by Amy Ha on 25/03/2022.
//  Copyright © 2022 Amy Ha. All rights reserved.
//

import SwiftUI

struct LogAssessmentView_Previews: PreviewProvider {
    static var previews: some View {
        LogAssessmentView()
    }
}

struct LogAssessmentView: View {
    
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    
    var data: WorkoutPlaceholderData!
    var activityViewModel: ActivityViewModel!
    
    init() {

        data = WorkoutPlaceholderData()
        activityViewModel = ActivityViewModel(data: data)
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Colours.primaryDark, .font: UIFont.outfitBold(size: 32)]

    }
    
    var body: some View {
        
        NavigationView{
            VStack {
                LogView(icon: "", text: "Log your mood", colour: Colours.moodColor)
                Spacer().frame(height: 20)
                LogView(icon: "", text: "Log your energy levels", colour: Colours.fatigueColor)
                Spacer().frame(height: 20)
                LogView(icon: "", text: "Log your pain levels", colour: Colours.painColor)
                
            }.navigationTitle(Text("How are you feeling?"))
                .offset(y: -90)
        }.frame(minHeight: minRowHeight * 18).font(Font.outfitBold(size: 20.0)).foregroundColor(.black)
    }
}

struct LogView: View {
    
    var icon: String
    var text: String
    var colour: Color
//    var activityViewModel: ActivityViewModel
    @State private var isWorkoutDisplayed = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35, style: .continuous).fill(Colours.grey01Color).frame(width: 340, height: 120)
            VStack {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .clipped().frame(width: 40, height: 60)
                Text(String(text)).font(.outfitRegular(size: 25)).foregroundColor(colour)
            }.frame(width: 300)
            
        }
//
//        .onTapGesture {
//            isWorkoutDisplayed = true
//        }
//        .sheet(isPresented: $isWorkoutDisplayed, onDismiss: {
//            print("the new workouts are... \(activityViewModel.LLworkouts.value)")
//        }, content: {
//            WorkoutPageView(workout: activityViewModel.LLworkouts.value[0])
//        })
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
