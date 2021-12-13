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
    internal var firebaseService: FirebaseService
    
    func areFieldsEmpty(credentials: UserCredentials) -> Bool {
        return credentials.email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        credentials.password.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    init(firebaseService: FirebaseService = FirebaseService()) {
        self.firebaseService = firebaseService
    }

    func performLogin(_ userCredentials: UserCredentials, completion: @escaping (Error?) ->()) {
        
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
}
