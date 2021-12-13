//
//  Workout.swift
//  RewireStroke
//
//  Created by Amy Ha on 07/04/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit

struct Workout: Identifiable {
    var id = UUID()
    var name: String
    var exercises: [Exercise]
    var activityType: ActivityType
    var image: String
}
