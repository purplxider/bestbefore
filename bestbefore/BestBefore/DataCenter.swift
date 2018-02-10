//
//  DataCenter.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 9..
//  Copyright © 2018년 0. All rights reserved.
//

import Foundation
import UIKit

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

let dataCenter = DataCenter()
let fileName = "FoodData.txt"
let alarmFileName = "AlarmData.txt"
let dDayFoodFileName = "dDayFoodData.txt"
let rottenFoodFileName = "rottenFoodData.txt"

class DataCenter {
    var foodArray:[Food] = []
    var alarmArray:[Alarm] = []
    var dDayFoodArray:[Food] = []
    var rottenFoodArray:[Food] = []
    
    var filePath:String { get {
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        
        return documentDirectory + "/" + fileName
        }}
    
    var alarmFilePath:String { get{
        
        let alarmDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        return alarmDirectory + "/" + alarmFileName
        }}
    
    var dDayFoodFilePath:String { get{
        
        let dDayFoodDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        return dDayFoodDirectory + "/" + dDayFoodFileName
        }}
    
    var rottenFoodFilePath:String { get{
        
        let rottenFoodDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        return rottenFoodDirectory + "/" + rottenFoodFileName
        }}
    
    init() {
        
//        if FileManager.default.fileExists(atPath: self.filePath) {
//            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? [Food] {
//                foodArray += unarchArray
//            }
//        } else {
//            var food1 = Food(name: nil, date: "18-02-02 ", dDay: 4, foodImage: #imageLiteral(resourceName: "food1"), foodColor: UIColorFromRGB(rgbValue: 0xFFD1D1))
//            var food2 = Food(name: nil, date: "18-02-06", dDay: 0, foodImage: #imageLiteral(resourceName: "food2"), foodColor: UIColorFromRGB(rgbValue: 0xFEFFD1))
//            var food3 = Food(name: nil, date: "18-02-08", dDay: -2, foodImage: #imageLiteral(resourceName: "food3"), foodColor: UIColorFromRGB(rgbValue: 0xD1FFD3))
//            var food4 = Food(name: nil, date: "18-02-07", dDay: -1, foodImage: #imageLiteral(resourceName: "food3"), foodColor: UIColorFromRGB(rgbValue: 0xD1FFD3))
//            var food5 = Food(name: nil, date: "18-02-20", dDay: -14, foodImage: #imageLiteral(resourceName: "food3"), foodColor: UIColorFromRGB(rgbValue: 0xD1FFD3))
//
//
//            foodArray.append(food1)
//            foodArray.append(food2)
//            foodArray.append(food3)
//            foodArray.append(food4)
//            foodArray.append(food5)
//        }
        
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(self.foodArray, toFile: self.filePath)
        NSKeyedArchiver.archiveRootObject(self.alarmArray, toFile: self.alarmFilePath)
        NSKeyedArchiver.archiveRootObject(self.dDayFoodArray, toFile: self.dDayFoodFilePath)
        NSKeyedArchiver.archiveRootObject(self.rottenFoodArray, toFile: self.rottenFoodFilePath)
        

    }
}
