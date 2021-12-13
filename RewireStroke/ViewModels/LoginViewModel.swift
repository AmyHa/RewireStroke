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

class LoginViewModel {
    
    private let firebaseService: FirebaseService
    
    init(firebaseService: FirebaseService = FirebaseService()) {
        self.firebaseService = firebaseService
    }
    
    // check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields(email: String, password: String) -> String? {
        
        // check that all fields are filled in
        if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
    }
    
    func increaseNumberOfLogins() {
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        if let user = user {
            UserManager.uid = user.uid
            db.collection("users").whereField("uid", isEqualTo: user.uid)
                .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting user document: \(err)")
                } else {
                    let userData = querySnapshot!.documents[0].data()
                    let userRef = querySnapshot!.documents[0].documentID

                    if let numberOfLogins = userData["numberOfLogins"] as? Int {
                            db.collection("users").document(userRef).updateData([
                            "numberOfLogins": numberOfLogins+1
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated")
                            }
                        }
                    }
                }
            }
        }
    }

    func performLogin(email: String, password: String, completion: @escaping (Error?) ->()) {
        firebaseService.login(email: email, password: password) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}
