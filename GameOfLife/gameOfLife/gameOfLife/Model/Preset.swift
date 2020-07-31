//
//  Preset.swift
//  gameOfLife
//
//  Created by Keri Levesque on 7/30/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import Foundation
import UIKit


public class Preset {
    
    //MARK: Properties
    
     var _name = NSLocalizedString("Oscillator", comment: "")
     var cells:[CGPoint] {
            get {
                return []
            }
        }
        var name:String  {
            get {
                return _name
            }
        }
        
        var size:CGSize {
            get {
                var xMin = -1
                var xMax = -1
                var yMin = -1
                var yMax = -1
                
                for (index, point) in self.cells.enumerated() {
                    let x = Int(point.x)
                    let y = Int(point.y)
                    if index == 0 {
                        xMin = x
                        xMax = x
                        yMin = y
                        yMax = y
                    }
                    if xMin > x {
                        xMin = x
                    }
                    if xMax < x {
                        xMax = x
                    }
                    if yMin > y {
                        yMin = x
                    }
                    if yMax < y {
                        yMax = y
                    }
                }
                return CGSize(width: xMax - xMin + 1, height: yMax - yMin + 1)
            }
        }
    
}

public class PresetOne: Preset {

    override init() {
        super.init()
        _name = NSLocalizedString("Preset 1", comment: "")
    }
    override var cells:[CGPoint] {
        get {
            return  [
                CGPoint(x:0, y:0),
                CGPoint(x:1, y:0),
                CGPoint(x:2, y:0)
            ]
        }
    }
}

class PresetTwo: Preset {
    override init() {
        super.init()
        _name = NSLocalizedString("Preset 2", comment: "")
    }
    override var cells:[CGPoint] {
        get {
            return [
                CGPoint(x:3, y:0),
                CGPoint(x:4, y:0),
                
                CGPoint(x:2, y:1),
                CGPoint(x:5, y:1),

                CGPoint(x:1, y:2),
                CGPoint(x:6, y:2),

                CGPoint(x:0, y:3),
                CGPoint(x:0, y:4),

                CGPoint(x:7, y:3),
                CGPoint(x:7, y:4),

                CGPoint(x:1, y:5),
                CGPoint(x:6, y:5),

                CGPoint(x:2, y:6),
                CGPoint(x:5, y:6),

                CGPoint(x:3, y:7),
                CGPoint(x:4, y:7),

            ]
        }
    }
}

class PresetThree: Preset {
    override init() {
        super.init()
        _name = NSLocalizedString("Preset 3", comment: "")
    }
    override var cells:[CGPoint] {
        get {
            return [
                CGPoint(x:1, y:0),
                CGPoint(x:3, y:1),
                CGPoint(x:0, y:2),
                CGPoint(x:1, y:2),
                CGPoint(x:4, y:2),
                CGPoint(x:5, y:2),
                CGPoint(x:6, y:2)
            ]
        }
    }
}
