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
    case emptyDetails
}

class LoginViewModel {
    
    private let firebaseService: FirebaseService
    
    init(firebaseService: FirebaseService = FirebaseService()) {
        self.firebaseService = firebaseService
    }
    
    func areFieldsEmpty(email: String, password: String) -> Bool {
        
        return email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        password.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }

    func performLogin(email: String, password: String, completion: @escaping (Error?) ->()) {
        
        if self.areFieldsEmpty(email: email, password: password) {
            completion(LoginError.emptyDetails)
        } else {
            firebaseService.login(email: email, password: password) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
