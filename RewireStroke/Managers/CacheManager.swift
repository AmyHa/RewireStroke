//
//  CacheManager.swift
//  RewireStroke
//
//  Created by Amy Ha on 07/03/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import UIKit

class CacheManager {
    
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
