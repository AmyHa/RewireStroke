//
//  Result.swift
//  RewireStroke
//
//  Created by Amy Ha on 09/12/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit

struct Result: Identifiable, Codable {
    var id = UUID()
    
    var type: String
    var value: Int // Value between 1-4
    var date: Int64
}
