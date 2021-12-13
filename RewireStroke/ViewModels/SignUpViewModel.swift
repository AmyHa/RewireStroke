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

class SignUpViewModel: CredentialsViewModel {
    internal var firebaseService: FirebaseService
    
    func areFieldsEmpty(credentials: UserCredentials) -> Bool {
        return credentials.email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        credentials.password.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        credentials.firstName?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        credentials.lastName?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    init(firebaseService: FirebaseService = FirebaseService()) {
        self.firebaseService = firebaseService
    }
    
    func performSignUp(userCredentials: UserCredentials, completion: @escaping (Error?) ->()) {
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
