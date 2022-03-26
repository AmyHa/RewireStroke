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
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Colours.primaryDark, .font: UIFont.outfitSemiBold(size: 32)]

    }
    
    var body: some View {
        
        let moodScaleView = ScaleView(icons: ["iconHappyFace", "iconOkFace", "iconSadFace", "iconLowFace"], labels: ["I'm happy", "I feel okay", "I feel sad", "I feel really low"], navTitle: "How do you feel?")
        let painScaleView = ScaleView(icons: ["iconPainFree", "iconPainMinor", "iconPainMajor", "iconPainSevere"], labels: ["I'm painfree", "I have some minor aches", "Pain is impacting on \nmy daily function", "I am in severe pain"], navTitle: "Are you in pain?")
        let fatigueScaleView = ScaleView(icons: ["iconBatteryFull", "iconBatteryThreeQuarters", "iconBatteryHalf", "iconBatteryLow"], labels: ["I'm full of beans!", "I'm able to \ncomplete my daily activities", "I feel tired", "I have very little energy"], navTitle: "How much energy do you have?")
        NavigationView{
            VStack {
                LogView(icon: "iconHappyFace", text: "Log your mood", colour: Colours.moodColor, scaleView: moodScaleView)
                Spacer().frame(height: 20)
                LogView(icon: "iconBattery", text: "Log your energy levels", colour: Colours.fatigueColor, scaleView: fatigueScaleView)
                Spacer().frame(height: 20)
                LogView(icon: "iconPainCircles", text: "Log your pain levels", colour: Colours.painColor, scaleView: painScaleView)
                
            }.navigationTitle(Text("How are you feeling?"))
                .offset(y: -90)
        }
    }
}

struct LogView: View {
    
    var icon: String
    var text: String
    var colour: Color
    var scaleView: ScaleView

    @State private var isWorkoutDisplayed = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35, style: .continuous).fill(Colours.grey01Color).frame(width: 340, height: 120)
            VStack {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .clipped().frame(width: 60, height: 40)
                Text(String(text)).font(.outfitRegular(size: 25)).foregroundColor(colour)
            }.frame(width: 300)
            
        }
        .onTapGesture {
            isWorkoutDisplayed = true
        }
        .sheet(isPresented: $isWorkoutDisplayed, onDismiss: {
            
        }, content: {
            scaleView
        })
    }
}

struct ScaleView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var icons: [String]
    var labels: [String]
    var navTitle: String
    
    @State var maxHeight: CGFloat = 320
    @State var sliderProgress: CGFloat = 0
    @State var sliderHeight: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    
    var body: some View {
        NavigationView {
            
            VStack {
                HStack{
                    VStack{
                        HStack{
                            Image(icons[0])
                                .resizable()
                                .scaledToFit()
                                .clipped().frame(width: 70, height: 40)
                            Text(String(labels[0])).font(.outfitRegular(size: 18))
                        }.frame(width: 260, alignment: .leading)
                        Spacer().frame(height: 50)
                        HStack{
                            Image(icons[1])
                                .resizable()
                                .scaledToFit()
                                .clipped().frame(width: 70, height: 40)
                            Text(String(labels[1])).font(.outfitRegular(size: 18))
                        }.frame(width: 260, alignment: .leading)
                        Spacer().frame(height: 50)
                        HStack{
                            Image(icons[2])
                                .resizable()
                                .scaledToFit()
                                .clipped().frame(width: 70, height: 40)
                            Text(String(labels[2])).font(.outfitRegular(size: 18))
                        }.frame(width: 260, alignment: .leading)
                        Spacer().frame(height: 50)
                        HStack{
                            Image(icons[3])
                                .resizable()
                                .scaledToFit()
                                .clipped().frame(width: 70, height: 40)
                            Text(String(labels[3])).font(.outfitRegular(size: 18))
                        }.frame(width: 260, alignment: .leading)
                    }.foregroundColor(Colours.primaryDarkColor)
                    ZStack(alignment: .bottom, content: {
                        
                        RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Colours.grey02Color)
                        RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Colours.primaryBlueColor).frame(height: sliderHeight)
                    })
                    .frame(width: 20, height: maxHeight)
                        .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                            
                            // getting drag value
                            let translation = value.translation
                            sliderHeight = -translation.height + lastDragValue
                            
                            // limiting slider height value
                            sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                            sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                        }).onEnded({ value in
                            // storing last drag value
                            lastDragValue = sliderHeight
                        })
                        )
                    
                }
                Spacer().frame(height: 50)
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Colours.primaryBlueColor)
                            .frame(width: 110, height: 45)
                        Text("Submit").font(.outfitSemiBold(size: 15))
                            .padding()
                            .foregroundColor(.white)
                    }
                    
                }
            }.navigationTitle(navTitle)
            
        }
    }
}

