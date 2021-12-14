//
//  SignUpViewModel.swift
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

class SignUpViewModel: CredentialsViewModel {
    
    func transitionToWelcomePage(view: UIView) {
        view.window?.rootViewController = WelcomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        view.window?.makeKeyAndVisible()
    }
    
    func performSignUp(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Error?) ->()) {
        
        let userCredentials = UserCredentials(email: email, password: password, firstName: firstName, lastName: lastName)
        
        if self.areFieldsEmpty(credentials: userCredentials) {
            completion(CredentialsError.emptyDetails)
        } else {
            firebaseService.createNewUser(userCredentials) { error in
                completion(error)
            }
            completion(nil)
        }
    }
}
