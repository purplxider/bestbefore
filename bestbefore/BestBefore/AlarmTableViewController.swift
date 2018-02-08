//
//  AlarmTableViewController.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 7..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class AlarmTableViewController: UITableViewController {
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func Vibrate(_ sender: Any){
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
    } // 진동
    
    @IBAction func Sound(_ sender: Any) { AudioServicesPlaySystemSound(SystemSoundID(1005))
    } // 소리
    
    @IBOutlet weak var Vibrate: UIButton!
    @IBAction func colorChangeVibrate(_ sender: Any) {
        UIView.animate(withDuration: 1, animations: { self.Vibrate.backgroundColor = self.UIColorFromRGB(rgbValue: 0xFFD1D1) })
    } // 진동 색깔
    
    @IBOutlet weak var Sound: UIButton!
    @IBAction func colorChangeSound(_ sender: Any) {
        UIView.animate(withDuration: 1, animations: { self.Vibrate.backgroundColor = self.UIColorFromRGB(rgbValue: 0xFFD1D1) })
    } //소리 색깔
    
    
    @IBOutlet weak var Date: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //    @IBOutlet weak var datePickerTxt: UITextField! // 시간 설정
    //    @IBOutlet weak var dayPickerTxt: UITextField! // 날짜 설정
    //
    //    let datePicker = UIDatePicker()
    //    let counts = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]
    //    var countPicker = UIPickerView()
    //    var dayPicker = UIPickerView()
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        createDatePicker()
    //
    //        dayPicker.delegate = self
    //        dayPicker.dataSource = self
    //        dayPickerTxt.inputView = dayPicker
    //
    //    }
    //    // 시간 설정
    //    func createDatePicker() {
    //        datePicker.datePickerMode = .time
    //
    //        let toolbar = UIToolbar()
    //        toolbar.sizeToFit()
    //
    //        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
    //        toolbar.setItems([doneButton], animated: false)
    //        datePickerTxt.inputAccessoryView = toolbar
    //        datePickerTxt.inputView = datePicker
    //    }
    //
    //    @objc func donePressed() {
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateStyle = .none
    //        dateFormatter.timeStyle = .short
    //        datePickerTxt.text = "\(dateFormatter.string(from: datePicker.date))"
    //        self.view.endEditing(true)
    //    }
    //
    //
    //    //날짜 설정
    //    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    //        return 1
    //    }
    //    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    //        return counts.count
    //    }
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return counts[row]
    //    }
    //    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //        dayPickerTxt.text = counts[row]
    //        dayPickerTxt.resignFirstResponder()
    //    }
    //
    //}
    
}
