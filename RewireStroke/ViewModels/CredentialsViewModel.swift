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

protocol CredentialsViewModel {
    var firebaseService: FirebaseService { get set }
    
    func areFieldsEmpty(credentials: UserCredentials) -> Bool
}
