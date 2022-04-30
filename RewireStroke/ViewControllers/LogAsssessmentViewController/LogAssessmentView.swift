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
        let fatigueScaleView = ScaleView(icons: ["iconBatteryFull", "iconBatteryThreeQuarters", "iconBatteryHalf", "iconBatteryLow"], labels: ["I'm full of beans!", "I'm able to \ncomplete my daily activities", "I feel tired", "I have very little energy"], navTitle: "Do you have energy?")
        NavigationView{
            VStack {
                LogView(icon: "iconHappyFace", text: "Log your mood", colour: Colours.moodColor, scaleView: moodScaleView)
                    .frame(maxHeight: .infinity)
                LogView(icon: "iconBattery", text: "Log your energy levels", colour: Colours.fatigueColor, scaleView: fatigueScaleView)
                    .frame(maxHeight: .infinity)
                LogView(icon: "iconPainCircles", text: "Log your pain levels", colour: Colours.painColor, scaleView: painScaleView)
                    .frame(maxHeight: .infinity)
            }.navigationTitle(Text("How are you feeling?"))
        }.frame(minHeight: minRowHeight * 18)
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
            RoundedRectangle(cornerRadius: 35, style: .continuous).fill(Colours.grey01Color).frame(width: 340, height: 150)
                .overlay(RoundedRectangle(cornerRadius: 35).stroke(colour, lineWidth: 1))
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
    
    @State var maxHeight: CGFloat = 480
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
                        }.frame(maxWidth: 280, maxHeight: .infinity, alignment: .leading)
                        HStack{
                            Image(icons[1])
                                .resizable()
                                .scaledToFit()
                                .clipped().frame(width: 70, height: 40)
                            Text(String(labels[1])).font(.outfitRegular(size: 18))
                        }.frame(maxWidth: 280, maxHeight: .infinity, alignment: .leading)
                        HStack{
                            Image(icons[2])
                                .resizable()
                                .scaledToFit()
                                .clipped().frame(width: 70, height: 40)
                            Text(String(labels[2])).font(.outfitRegular(size: 18))
                        }.frame(maxWidth: 280, maxHeight: .infinity, alignment: .leading)
                        HStack{
                            Image(icons[3])
                                .resizable()
                                .scaledToFit()
                                .clipped().frame(width: 70, height: 40)
                            Text(String(labels[3])).font(.outfitRegular(size: 18))
                        }.frame(maxWidth: 280, maxHeight: .infinity, alignment: .leading)
                    }.foregroundColor(Colours.primaryDarkColor)
                    ZStack(alignment: .bottom, content: {
                        
                        RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Colours.grey02Color)
                        RoundedRectangle(cornerRadius: 20, style: .continuous).fill(LinearGradient(gradient: Gradient(colors: [Colours.primaryDarkColor, Colours.primaryBlueColor]), startPoint: .top, endPoint: .bottom)).frame(height: sliderHeight)
                    })
                        .frame(width: 30, height: maxHeight)
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
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [Colours.primaryBlueColor, Colours.primaryDarkColor]), startPoint: .leading, endPoint: .trailing))
                            .frame(maxWidth: .infinity, maxHeight: 45)
                            .padding(.leading, 45)
                            .padding(.trailing, 45)
                        Text("Submit").font(.outfitSemiBold(size: 18))
                            .foregroundColor(.white)
                    }
                    
                }
            }.navigationTitle(navTitle)
                .navigationBarItems(trailing:                 Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(Colours.primaryDarkColor)
                })
        }
    }
}

