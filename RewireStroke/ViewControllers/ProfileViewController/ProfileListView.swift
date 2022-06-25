//
//  ProfileListView.swift
//  RewireStroke
//
//  Created by Amy Ha on 25/06/2022.
//  Copyright © 2022 Amy Ha. All rights reserved.
//

import SwiftUI

struct ProfileListView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListView()
    }
}

struct ProfileListView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Colours.primaryDark, .font: UIFont.outfitSemiBold(size: 32)]
    }
    
    @Environment(\.defaultMinListRowHeight) var minRowHeight

    var body: some View {
        
        NavigationView {
            ScrollView {
                ProfileItemView(title: "Personal Information")
                Divider().frame(width: 300)
                ProfileItemView(title: "Terms and Conditions")
                Divider().frame(width: 300)
                ProfileItemView(title: "Private Policy")
                Divider().frame(width: 300)
                ProfileItemView(title: "Support")
                Divider().frame(width: 300)
            }.navigationBarTitle("Profile")
        }.frame(minHeight: minRowHeight*18).font(Font.outfitMedium(size: 15.0)).foregroundColor(Colours.primaryDarkColor)
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
