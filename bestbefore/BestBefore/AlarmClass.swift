//
//  Alarm.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 8..
//  Copyright © 2018년 0. All rights reserved.
//

import Foundation
import UIKit

class Alarm: NSObject, NSCoding {
    var time:String
    var mode:String
    
    init (time:String, mode:String){
        self.time = time
        self.mode = mode
    }
    
    required init?(coder aDecoder: NSCoder) {
    
        self.time = aDecoder.decodeObject(forKey: "time") as! String
        self.mode = aDecoder.decodeObject(forKey: "mode") as! String
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.time, forKey: "time")
        aCoder.encode(self.mode, forKey: "mode")
    }
    
}
