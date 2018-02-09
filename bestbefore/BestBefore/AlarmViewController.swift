//
//  AlarmViewController.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 8..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit
import UserNotifications


class AlarmViewController: UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func datePickerAction(_ sender: Any) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var strDate = dateFormatter.string(from: datePicker.date)
        self.dateLabel.text = strDate
        
      
        
      
    }
    
    
    
    @IBAction func setAlarm(_ sender: Any) {
//
//        var now = Date()
//        var interval = getIntervalDays(date: now, anotherDay: datePicker.date) * 86400
        
        dataCenter.alarmArray.append(Alarm(time: dateLabel.text!, mode: ""))
        navigationController?.popViewController(animated: true)
    
        
        
        timedNotifications(inSeconds: 5) { (success) in
            if success {
                print("성공")
            }
        }
    
        dataCenter.save()
    }
    
    
    func timedNotifications(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()){
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let content = UNMutableNotificationContent()
        
        content.title = "유통기한 알림"
        content.subtitle = "몇개"
        content.body = "dsfsdf"
        
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
        
    
    
    
    
    
    func getIntervalDays(date: Date?, anotherDay: Date? = nil) -> Double {
        
        var interval: Double!
        
        if anotherDay == nil {
            interval = date?.timeIntervalSinceNow
        } else {
            interval = date?.timeIntervalSince(anotherDay!)
        }
        
        let r = interval / 86400
        
        return floor(r)
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
