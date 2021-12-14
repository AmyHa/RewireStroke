//
//  CredentialsViewModel.swift
//  RewireStroke
//
//  Created by Amy Ha on 13/12/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

enum CredentialsError: Error {
    case emptyDetails
}

class CredentialsViewModel {
    var firebaseService: FirebaseService
    
    init(firebaseService: FirebaseService = FirebaseService()) {
        self.firebaseService = firebaseService
    }
    
    func areFieldsEmpty(credentials: UserCredentials) -> Bool {
        return credentials.email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        credentials.password.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        credentials.firstName?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        credentials.lastName?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
}
