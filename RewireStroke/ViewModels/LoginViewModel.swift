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
        
        
        // tab bar icon
        let homeItem = UITabBarItem()
        homeItem.title = "Home"
        homeItem.image = UIImage(named: "iconHome")
        
        let activityItem = UITabBarItem()
        activityItem.title = "Activity"
        activityItem.image = UIImage(named: "iconActivity")

        let progressItem = UITabBarItem()
        progressItem.title = "Progress"
        progressItem.image = UIImage(named: "iconProgress")
        
        let infoItem = UITabBarItem()
        infoItem.title = "Info"
        infoItem.image = UIImage(named: "iconInfo")
        
        let profileItem = UITabBarItem()
        profileItem.title = "Profile"
        profileItem.image = UIImage(named: "iconProfile")
        
        homeViewController.tabBarItem = homeItem
        activityViewController.tabBarItem = activityItem
        progressViewController.tabBarItem = progressItem
        infoViewController.tabBarItem = infoItem
        profileViewController.tabBarItem = profileItem
        
        let tabBarController = UITabBarController()
        let controllers = [infoViewController, activityViewController, homeViewController, progressViewController, profileViewController]
        tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        
        tabBarController.selectedIndex = 2 // 2nd tab
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToWelcomePage(view: UIView) {
        view.window?.rootViewController = WelcomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        view.window?.makeKeyAndVisible()
    }
}
