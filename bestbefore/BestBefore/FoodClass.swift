//
//  FoodClass.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 1..
//  Copyright © 2018년 0. All rights reserved.
//

import Foundation
import UIKit



class Food {
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
    
}

//
//class AutoItem : Settings {
//    var bestBeforeDate:String
//    var autoImage:UIImage
//
//    func dday() {
//        //bestBeforeDate에서 현재 날짜 빼기
//        //dday가 얼마일때 어떤 색깔로 view 표시
//    }
//
//    init(alarmTimes:Int, alarmTypeBool: Bool, alarmDate: Int, bestBeforeDate:String, autoImage:UIImage) {
//        self.bestBeforeDate = bestBeforeDate
//        self.autoImage = autoImage
//        super.init(alarmTimes: alarmTimes, alarmTypeBool: alarmTypeBool, alarmDate: alarmDate)
//    }
//}
//
//class ManualItem : Settings {
//    var date:String
//    var manualImage:UIImage
//
//    func ddayCalculate() {
//        // date에서 앱 내에 저장된 값으로 디데이 계산
//    }
//
//    init(alarmTimes:Int, alarmTypeBool: Bool, alarmDate: Int, date:String, manualImage:UIImage){
//        self.date = date
//        self.manualImage = manualImage
//        super.init(alarmTimes: alarmTimes, alarmTypeBool: alarmTypeBool, alarmDate: alarmDate)
//    }
//}

