//
//  InfoListView.swift
//  RewireStroke
//
//  Created by Amy Ha on 22/06/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import SwiftUI
import UIKit

struct InfoListView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Colours.primaryDark, .font: UIFont.outfitSemiBold(size: 32)]
    }
    
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    var body: some View {
        
        NavigationView {
            List {
                InfoItemView(title: "Type of stroke")
                InfoItemView(title: "Treatment")
                InfoItemView(title: "Risk & Prevention")
            }.navigationBarTitle("Information")
        }.frame(minHeight: minRowHeight*18).font(Font.outfitMedium(size: 18.0)).foregroundColor(Colours.primaryBlueColor)
    }
}

struct InfoItemView: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    @State private var showSheet = false
    
    var title: String
    var body: some View {
        HStack {
            Button(title){ showSheet.toggle() }
                .frame(width: 350, height: 70, alignment: .leading)
                .sheet(isPresented: $showSheet, onDismiss: {
                }, content: {
                    StandardInfoView()
                })
            Image("listArrow")
                .scaledToFit()
                .frame(width: 30, height: 70, alignment: .trailing)
                .cornerRadius(5.0)
        }
    }
}

struct StandardInfoView: View {
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Colours.primaryDark, .font: UIFont.outfitBold(size: 20)]
    }
    
    var body: some View {

        NavigationView {
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("What is a stroke?")
                        .font(Font.outfitBold(size: 20.0)).foregroundColor(Colours.primaryDarkColor)
                    Spacer()
                        .frame(maxHeight: 20)
                    
                    Text("A stroke is caused by a disruption to the brain's blood supply").frame(maxHeight: .infinity)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(Font.outfitMedium(size: 14.0)).foregroundColor(Colours.primaryDarkColor)
                    
                    Spacer()
                        .frame(maxHeight: 20)
                    
                    Text("There are two main types:")
                        .font(Font.outfitRegular(size: 14.0)).foregroundColor(.black)
                    
                    Spacer()
                        .frame(maxHeight: 20)
                    
                    HStack{
                        Text("•").frame(maxHeight: .infinity, alignment: .top)
                        Text("An ischaemic stroke is caused by blockage of a blood vessel that supplies the brain. It accounts for around 85% of strokes.").frame(maxHeight: .infinity)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .font(Font.outfitRegular(size: 14.0)).foregroundColor(.black)
                    
                    Spacer()
                        .frame(maxHeight: 20)
                    
                    HStack{
                        Text("•").frame(maxHeight: .infinity, alignment: .top)
                        Text("A haemorrhagic stroke happens when a vessel in the brain bursts.").frame(maxHeight: .infinity)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .font(Font.outfitRegular(size: 14.0)).foregroundColor(.black)
                    
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                
                Image("infoPageBrainImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, alignment: .center)
                    .padding()
                
                Text("A transient ischaemic attack, or ‘mini-stroke’, is caused by a temporary clot. Symptoms resolve within 24 hours. However, it should be taken seriously as there’s significantly higher risk of getting having a full stroke in the near future.")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                    .font(Font.outfitRegular(size: 14.0)).foregroundColor(.black)
                
            }.frame(minHeight: 0, maxHeight: .infinity, alignment: .top).navigationBarTitle("Types of Stroke", displayMode: .inline)
        }
    }
    
}


struct InfoListView_Previews: PreviewProvider {
    static var previews: some View {
        InfoListView()
    }
}
