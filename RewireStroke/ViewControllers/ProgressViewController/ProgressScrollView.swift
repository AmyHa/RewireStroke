//
//  ProgressScrollView.swift
//  RewireStroke
//
//  Created by Amy Ha on 02/01/2022.
//  Copyright © 2022 Amy Ha. All rights reserved.
//

import UIKit
import SwiftUI

struct ProgressScrollView: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Colours.primaryDark, .font: UIFont.outfitSemiBold(size: 32)]
    }
    
    var body: some View {
        VStack {
            NavigationView {
                
                List {
                    Text("Pain")
                    ProgressChartView(type: .pain).frame(width: 200, height: 200, alignment: .center )
                    Text("Mood")
                    ProgressChartView(type: .mood).frame(width: 200, height: 200, alignment: .center )
                    Text("Fatigue")
                    ProgressChartView(type: .fatigue).frame(width: 200, height: 200, alignment: .center )
                }.navigationBarTitle("Progress")
            }
        }.frame(minHeight: minRowHeight * 20).font(Font.outfitBold(size: 20.0)).foregroundColor(.black)
    }
}

// We need the below to wrap a custom UIView for SwiftUI
struct ProgressChartView: UIViewRepresentable {
    
    var type: ChartType
    
    func updateUIView(_ uiView: CustomChartView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> CustomChartView {
        return CustomChartView(viewModel: ChartViewModel(type: type, results: [Result(id: UUID(), type: type, value: 1, date: 45545)]))
    }
    
}
