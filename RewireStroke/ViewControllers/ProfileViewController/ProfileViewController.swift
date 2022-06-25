//
//  ProfileViewController.swift
//  RewireStroke
//
//  Created by Amy Ha on 17/06/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit
import SwiftUI

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileView: UIView!

    private var host: UIHostingController<ProfileListView>!

    override func viewDidLoad() {
        super.viewDidLoad()

        /** Use the below if want large navigation title without SwiftUI (and no shadow beaneath title) **/
//        self.title = "Profile"
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.configureWithOpaqueBackground()
//        navBarAppearance.shadowColor = .clear
//        navBarAppearance.shadowImage = UIImage()
//        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.outfitSemiBold(size: 30), NSAttributedString.Key.foregroundColor: Colours.primaryDark]
//
//        navigationController?.navigationBar.standardAppearance = navBarAppearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        let profileListView = ProfileListView()
        host = UIHostingController(rootView: profileListView)
        
        guard let hostView = host.view else { return }
        profileView.addSubview(hostView)
        
        // Add constraints
        hostView.translatesAutoresizingMaskIntoConstraints = false
        hostView.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
        hostView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hostView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        hostView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
}
