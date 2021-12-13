//
//  FirebaseService.swift
//  RewireStroke
//
//  Created by Amy Ha on 13/12/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

class FirebaseService {
    
    var db = Firestore.firestore()
    
    init() {
        
    }
    
    func login(email: String, password: String, completion: @escaping (Error?) -> ()) {
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if error != nil {
                completion(error)
            } else {
                self.increaseNumberOfLogins()
                completion(nil)
            }
        }
    }
    
    func createNewUser(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            // If there was an error creating the user – don't add users details to the "users" table
            if let error = err {
                completion(err)
            } else {
                self.db.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "uid": result?.user.uid, "numberOfLogins": 1]) { (error) in
                    completion(error)
                }
                
                completion(nil)
            }
            
        }
    }
    
    func increaseNumberOfLogins() {
        let user = Auth.auth().currentUser
        if let user = user {
            UserManager.uid = user.uid
            self.db.collection("users").whereField("uid", isEqualTo: user.uid)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting user document: \(err)")
                    } else {
                        let userData = querySnapshot!.documents[0].data()
                        if let numberOfLogins = userData["numberOfLogins"] as? Int {
                            if numberOfLogins > 0 {
                                print("whoo greater than 0")
                            } else {
                                print("whoo not greater than 0")
                            }
                        }
                    }
            }
        }
    }
}
