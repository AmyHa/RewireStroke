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

enum LoginError: Error {
    case incompleteDetails
}

class LoginViewModel {
    
    private let firebaseService: FirebaseService
    
    init(firebaseService: FirebaseService = FirebaseService()) {
        self.firebaseService = firebaseService
    }
    
    func areFieldsComplete(email: String, password: String) -> Bool {
        
        // check that all fields are filled in
        if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return false
        } else {
            return true
        }
    }

    func performLogin(email: String, password: String, completion: @escaping (Error?) ->()) {
        
        if self.areFieldsComplete(email: email, password: password) {
            firebaseService.login(email: email, password: password) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }            
        } else {
            completion(LoginError.incompleteDetails)
        }
        
    }
}
