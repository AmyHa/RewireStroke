//
//  User.swift
//  RewireStroke
//
//  Created by Amy Ha on 13/12/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

struct UserCredentials {
    var email: String
    var password: String
    var firstName: String?
    var lastName: String?
    
    
    init?(email: String, password: String, firstName: String?, lastName: String?) {
        self.email = email
        self.password = password
        
        if let firstName = firstName, let lastName = lastName {
            self.firstName = firstName
            self.lastName = lastName
        }
    }
}
