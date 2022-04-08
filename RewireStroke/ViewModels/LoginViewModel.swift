//
//  LoginViewModel.swift
//  RewireStroke
//
//  Created by Amy Ha on 13/12/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

class LoginViewModel: CredentialsViewModel {

    func performLogin(email: String, password: String, completion: @escaping (Error?) ->()) {
        
        let userCredentials = UserCredentials(email: email, password: password)
        if self.areFieldsEmpty(credentials: userCredentials) {
            completion(CredentialsError.emptyDetails)
        } else {
            firebaseService.login(userCredentials) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func transitionToHome(view: UIView) {
        // Since numberOfLogins > 0, then just transition to the homepage
        let homeViewController = HomeViewController.init(nibName: Constants.View.homeViewController, bundle: nil)
        let activityViewController = ActivityViewController.init(nibName: Constants.View.activityViewController, bundle: nil)
        let progressViewController = ProgressViewController.init(nibName: Constants.View.progressViewController, bundle: nil)
        let infoViewController = InfoViewController.init(nibName: Constants.View.infoViewController, bundle: nil)
        let profileViewController = ProfileViewController.init(nibName: Constants.View.profileViewController, bundle: nil)
        
        let homeIcon = UIImage(named: "iconHome")!.withRenderingMode(.alwaysOriginal)
        let homeIconSelected = UIImage(named: "iconHomeSelected")!.withRenderingMode(.alwaysOriginal)
        let homeItem = UITabBarItem(title: "Home", image: homeIcon, selectedImage: homeIconSelected)
        homeItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        homeItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colours.primaryIcon], for: .selected)

        let activityIcon = UIImage(named: "iconActivity")!.withRenderingMode(.alwaysOriginal)
        let activityIconSelected = UIImage(named: "iconActivitySelected")!.withRenderingMode(.alwaysOriginal)
        let activityItem = UITabBarItem(title: "Activity", image: activityIcon, selectedImage: activityIconSelected)
        activityItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        activityItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colours.primaryIcon], for: .selected)

        let progressIcon = UIImage(named: "iconProgress")!.withRenderingMode(.alwaysOriginal)
        let progressIconSelected = UIImage(named: "iconProgressSelected")!.withRenderingMode(.alwaysOriginal)
        let progressItem = UITabBarItem(title: "Progress", image: progressIcon, selectedImage: progressIconSelected)
        progressItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        progressItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colours.primaryIcon], for: .selected)

        let infoItem = UITabBarItem()
        infoItem.title = "Info"
        infoItem.image = UIImage(named: "iconInfo")
        infoItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        infoItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colours.primaryIcon], for: .selected)
        
        let profileIcon = UIImage(named: "iconProfile")!.withRenderingMode(.alwaysOriginal)
        let profileIconSelected = UIImage(named: "iconProfileSelected")!.withRenderingMode(.alwaysOriginal)
        let profileItem = UITabBarItem(title: "Profile", image: profileIcon, selectedImage: profileIconSelected)
        profileItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        profileItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colours.primaryIcon], for: .selected)
        
        homeViewController.tabBarItem = homeItem
        activityViewController.tabBarItem = activityItem
        progressViewController.tabBarItem = progressItem
        infoViewController.tabBarItem = infoItem
        profileViewController.tabBarItem = profileItem
        
        let tabBarController = CustomTabController()
        let controllers = [infoViewController, progressViewController, homeViewController, activityViewController, profileViewController]
        tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        
        tabBarController.selectedIndex = 2 // 2nd tab
        tabBarController.tabBar.unselectedItemTintColor = Colours.primaryIcon
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToWelcomePage(view: UIView) {
        view.window?.rootViewController = WelcomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        view.window?.makeKeyAndVisible()
    }
}
