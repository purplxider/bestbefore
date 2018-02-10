//
//  FoodClass.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 1..
//  Copyright © 2018년 0. All rights reserved.
//

import Foundation
import UIKit



class Food:NSObject, NSCoding {
    var name:String?
    var date:String
    var dDay:Int
    var foodImage:UIImage
    var foodColor:UIColor
    
    init (name:String?, date:String, dDay:Int, foodImage:UIImage, foodColor:UIColor){
        self.name = name
        self.date = date
        self.dDay = dDay
        self.foodImage = foodImage
        self.foodColor = foodColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.date = aDecoder.decodeObject(forKey: "date") as! String
        self.dDay = aDecoder.decodeInteger(forKey: "dDay")
        self.foodImage = aDecoder.decodeObject(forKey: "foodImage") as! UIImage
        self.foodColor = aDecoder.decodeObject(forKey: "foodColor") as! UIColor
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.date, forKey: "date")
        aCoder.encode(self.dDay, forKey: "dDay")
        aCoder.encode(self.foodImage, forKey: "foodImage")
        aCoder.encode(self.foodColor, forKey: "foodColor")
    }
}

class DdayFood:NSObject, NSCoding {
    var dDayFood:[Food] = []
    
    init (dDayFood:[Food]) {
        self.dDayFood = dDayFood
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.dDayFood = aDecoder.decodeObject(forKey: "dDayFood") as! [Food]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.dDayFood, forKey: "dDayFood")

    }
    
}

class RottenFood:NSObject, NSCoding {
    var rottenFood:[Food] = []

    init (rottenFood:[Food]) {
        self.rottenFood = rottenFood
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.rottenFood = aDecoder.decodeObject(forKey: "rottenFood") as! [Food]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.rottenFood, forKey: "rottenFood")
    }
}
