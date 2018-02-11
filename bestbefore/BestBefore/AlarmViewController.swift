//
//  AlarmViewController.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 8..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit
import UserNotifications
import Foundation


class AlarmViewController: UIViewController, UINavigationControllerDelegate {
    
    
    
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func datePickerAction(_ sender: Any) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var strDate = dateFormatter.string(from: datePicker.date)
        self.dateLabel.text = strDate
        
    }
    
    
    //저장하는 버튼
    @IBAction func setAlarm(_ sender: Any) {
//
//        var now = Date()
//        var interval = getIntervalDays(date: now, anotherDay: datePicker.date) * 86400
        var now = Date()
        var dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yy-MM-dd"
        var fomattedNow = dateFomatter.string(from: now)
        
        var foods:[Food] = dataCenter.foodArray
        var dDayFoods:[Food] = dataCenter.dDayFoodArray
        var rottenFoods:[Food] = dataCenter.rottenFoodArray
        
        for food in foods {
            if food.dDay > 0 {
                if rottenFoods.contains(food) != true {
                    rottenFoods.append(food)
                    print("버릴식품 추가 결과 \(food.dDay) \(fomattedNow)")

                }
            } else {
                if rottenFoods.contains(food) {
                    if let index = rottenFoods.index(of: food) {
                        rottenFoods.remove(at: index)
                    }
                }
            }
        }
        
       
        for food in foods {
            if food.date == fomattedNow {
                if dDayFoods.contains(food) != true {
                     dDayFoods.append(food)
                    print("디데이푸드 추가 결과 \(food.date) \(fomattedNow)")
                    
                }
            } else if food.date != fomattedNow {
                if dDayFoods.contains(food) {
                    if let index = dDayFoods.index(of: food) {
                        dDayFoods.remove(at: index)
                    }
                }
            }
        }
        dataCenter.dDayFoodArray = dDayFoods
        dataCenter.rottenFoodArray = rottenFoods
        
        
        print("디데이푸드 추가 \(dataCenter.dDayFoodArray)")
        
        
        dataCenter.alarmArray.append(Alarm(time: dateLabel.text!, mode: ""))
        navigationController?.popViewController(animated: true)
        
      
        
        var datecomponents = DateComponents()
        

        datedNotifications(dateComponents: datecomponents) { (success) in
            if success {
                print("성공입니다.")
                
            }
        }
    
        
    
        dataCenter.save()
    }
    
    //로컬 알림 함수
    func datedNotifications(dateComponents: DateComponents, completion: @escaping (_ Success: Bool) -> ()){
        let local = UILocalNotification()
        
        var dateComponents = DateComponents()
        var pickeredTime = self.datePicker.date
        
        
        var hourFomatter = DateFormatter()
        hourFomatter.dateFormat = "HH"
        var minFomatter = DateFormatter()
        minFomatter.dateFormat = "mm"
        
        var hour = hourFomatter.string(from: pickeredTime)
        var minute = minFomatter.string(from: pickeredTime)
        
//        var time = DateComponents()
//        time.hour = Int(hour)
//        time.minute = Int(minute)
//
//        dateComponents.hour = time.hour
//        dateComponents.minute = time.minute
//        dateComponents.second = 0
//        dateComponents.isLeapMonth = true
//        print("\(dateComponents) 제발좀")
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        let content = UNMutableNotificationContent()
        var daily = DateComponents()
        daily.hour = Int(hour)
        daily.minute = Int(minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: daily, repeats: true)
        let content = UNMutableNotificationContent()
        
        let nextDate = trigger.nextTriggerDate()
        
        
        content.title = "유통기한 알림"
        content.body = "오늘까지 먹어야할 식품이 \(dataCenter.dDayFoodArray.count)개 있습니다.\n유통기한이 지난 식품이 \(dataCenter.rottenFoodArray.count)개 있습니다. 확인하세요!"
        
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if error != nil {
                print("Authorization Unsuccessful")
            } else {
                print("Successful")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
