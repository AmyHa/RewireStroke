//
//  IntExtension.swift
//  RewireStroke
//
//  Created by Amy Ha on 17/12/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

// Taken from: https://stackoverflow.com/questions/26794703/swift-integer-conversion-to-hours-minutes-seconds
extension Int {

    var timeFormat: String {

        let (m,s) = ((self % 3600) / 60, (self % 3600) % 60)

        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"

        return "\(m_string):\(s_string)"
    }
}
