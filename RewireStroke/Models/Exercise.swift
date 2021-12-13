//
//  Activity.swift
//  RewireStroke
//
//  Created by Amy Ha on 21/03/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//
import UIKit

struct Exercise: Hashable, Identifiable {
    
    var id = UUID()
    var name: String
    var activityType: ActivityType
    var ability: Ability
    var image: String
    var videoPath: String = ""
}


enum Ability {
    case little, fully
}


