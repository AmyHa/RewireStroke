//
//  ChartViewModel.swift
//  RewireStroke
//
//  Created by Amy Ha on 01/01/2022.
//  Copyright © 2022 Amy Ha. All rights reserved.
//

import Charts

struct ChartViewModel {
    var type: ChartType
    var results: [Result] = []
    var chartData: [ChartDataEntry] = []
    
    init(type: ChartType, results: [Result]) {
        self.results = results
        self.type = type
        
    }
}

enum ChartType: String, Codable {
    case pain
    case fatigue
    case mood
    
    var themeColour: UIColor {
        switch self {
            
        case .pain:
            return Colours.pain
        case .fatigue:
            return Colours.fatigue
        case .mood:
            return Colours.mood
        }
    }
}
