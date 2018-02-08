//
//  AlarmViewController.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 8..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController, UINavigationControllerDelegate {
    
    var delegate: AlarmListTableViewController?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func datePickerAction(_ sender: Any) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var strDate = dateFormatter.string(from: datePicker.date)
        self.dateLabel.text = strDate
        
    }
    
    
    
    @IBAction func setAlarm(_ sender: Any) {
        if let alarmListVC = delegate {
            
            
            
  
            
            
            
//                listVC.foods.append(Food(name: nameTextField.text!, date: dateTextField.text!, dDay: Int(getDday), foodImage:  addFoodImage, foodColor: getColor))
            
            navigationController?.popViewController(animated: true)
            
            
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
