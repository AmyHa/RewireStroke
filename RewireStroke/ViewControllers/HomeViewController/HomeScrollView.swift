//
//  HomeScrollView.swift
//  RewireStroke
//
//  Created by Amy Ha on 12/03/2022.
//  Copyright © 2022 Amy Ha. All rights reserved.
//

import SwiftUI
import UIKit

struct HomeScrollView: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    
    init() {
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Colours.primaryDark, .font: UIFont.rajdhaniSemiBold(size: 32)]
    }
    
    var body: some View {
        
        VStack{
            NavigationView {
                
                List {
                    Image("little-ankle-plantarflexion")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 100)
                        .cornerRadius(5.0)
                    Image("little-ankle-plantarflexion")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 100)
                        .cornerRadius(5.0)
                    Image("little-ankle-plantarflexion")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 100)
                        .cornerRadius(5.0)
                }.navigationBarTitle("Select an Activity")
                
            }.frame(minHeight: minRowHeight * 20).font(Font.robotoBold(size: 20.0)).foregroundColor(.black)
        }
    }
}
