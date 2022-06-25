//
//  ProfileListView.swift
//  RewireStroke
//
//  Created by Amy Ha on 25/06/2022.
//  Copyright © 2022 Amy Ha. All rights reserved.
//

import SwiftUI

struct ProfileListView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Colours.primaryDark, .font: UIFont.outfitSemiBold(size: 32)]
    }
    
    @Environment(\.defaultMinListRowHeight) var minRowHeight

    var body: some View {
        
        NavigationView {
            List {
                ProfileItemView(title: "Personal Information")
                ProfileItemView(title: "Terms and Conditions")
                ProfileItemView(title: "Private Policy")
                ProfileItemView(title: "Support")
            }.navigationBarTitle("Profile")
        }.frame(minHeight: minRowHeight*18).font(Font.outfitMedium(size: 18.0)).foregroundColor(Colours.primaryBlueColor)
    }
}


struct ProfileItemView: View {
    
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    @State private var showSheet = false
    
    var title: String
    var body: some View {
        HStack {
            Button(title){ showSheet.toggle() }
                .frame(width: 250, height: 70, alignment: .leading)
                .sheet(isPresented: $showSheet, onDismiss: {
                }, content: {
                    StandardInfoView()
                })
            Image(systemName: "chevron.right")
                .scaledToFit()
                .frame(width: 30, height: 70, alignment: .trailing)
        }
    }
}
