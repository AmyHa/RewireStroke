//
//  ChartViewModel.swift
//  RewireStroke
//
//  Created by Amy Ha on 01/01/2022.
//  Copyright © 2022 Amy Ha. All rights reserved.
//

import Charts

struct ChartViewModel {
    var results: [Result] = []
    var chartData: [ChartDataEntry] = []
    
    init(results: [Result]) {
        self.results = results
    }
}
