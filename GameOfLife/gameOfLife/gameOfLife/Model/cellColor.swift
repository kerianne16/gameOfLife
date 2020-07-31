//
//  cellColor.swift
//  gameOfLife
//
//  Created by Keri Levesque on 7/29/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import Foundation
import UIKit

class CellColor {

    // Singleton Class
    static let shared = CellColor()
    var cellColorIndex:Int = 0

    var cellColor:UIColor {
        get {
            return self.colors[cellColorIndex]
        }
    }
    
    let colors = [
        UIColor.systemTeal,
        UIColor.systemGray,
        UIColor.systemBlue,
        UIColor.systemIndigo,
        UIColor.systemGreen,
        UIColor.systemOrange,
        UIColor.systemPurple,
        UIColor.systemYellow,
        UIColor.systemRed,
        UIColor.label
    ]
    
    private init() {
    
    }
}

