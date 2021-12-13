//
//  SignUpViewModel.swift
//  RewireStroke
//
//  Created by Amy Ha on 13/12/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

enum SignUpError: Error {
    case emptyDetails
}

class SignUpViewModel {
    
    private let firebaseService: FirebaseService
    
    init(firebaseService: FirebaseService = FirebaseService()) {
        self.firebaseService = firebaseService
    }
    
    func areFieldsEmpty(email: String, password: String, firstname: String, lastname: String) -> Bool {
        
        return email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        password.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        firstname.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastname.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    func performSignUp(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Error?) ->()) {
        if self.areFieldsEmpty(email: email, password: password, firstname: firstName, lastname: lastName) {
            completion(SignUpError.emptyDetails)
        } else {
            firebaseService.createNewUser(email: email, password: password, firstName: firstName, lastName: lastName) { error in
                completion(error)
            }
            completion(nil)
        }
    }
}
