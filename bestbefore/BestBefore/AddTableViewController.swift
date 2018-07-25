//
//  AddTableViewController.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 6..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
//    var delegate:DataCenter?
    
    var now = Date()
    let formatter = DateFormatter()
    
    @IBOutlet weak var addAnImageLabel: UIButton!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBAction func setCreater(_ sender: Any) {
        guard addImage.image != nil else {
            showToast(message: "사진을 입력해주세요")
            return
        }
        
        guard nameTextField.text != "" else {
            showToast(message: "이름을 입력해주세요")
            return
        }
        
        guard dateTextField.text != "" else {
            showToast(message: "유통기한을 입력해주세요")
            return
        }
        
        formatter.dateFormat = "yy-MM-dd"
        
        var foodDate = formatter.date(from: dateTextField.text!)
        var getDday = getIntervalDays(date: now, anotherDay: foodDate)
        var getColor:UIColor = UIColorFromRGB(rgbValue: 0xFF0000)
        
        if getDday > 0 {
            getColor = UIColorFromRGB(rgbValue: 0xFFD1D1)
            
        } else if getDday > -2 {
            getColor = UIColorFromRGB(rgbValue: 0xFEFFD1)
            
        } else {
            getColor = UIColorFromRGB(rgbValue: 0xD1FFD3)
            
        }
        
        
        dataCenter.foodArray.append(Food(name: nameTextField.text!, date: dateTextField.text!, dDay: Int(getDday), foodImage:  addImage.image!, foodColor: getColor))
        dataCenter.save()
        
        
        
        //    }
        
    self.navigationController?.popViewController(animated: true)
    }
   
    
    override func viewDidAppear(_ animated: Bool) {
        if addImage.image != nil {
            addAnImageLabel.isHidden = true
        }
        
        if let recognizedText = UserDefaults.standard.string(forKey: "recognizedText") {
            UserDefaults.standard.set(nil, forKey: "recognizedText")
            let censoredText = censorText(text: recognizedText)
            dateTextField.text = censoredText
        }
        
        if let imageData = UserDefaults.standard.data(forKey: "savedImageData") {
            UserDefaults.standard.set(nil, forKey: "savedImageData")
            let savedImage = UIImage(data: imageData)
            addImage.image = savedImage
        }
    }
    
    func censorText(text: String?) -> String {
        guard let tempText = text else {
            showToast(message: "인식된 글씨가 없습니다")
            return ""
        }
        var editText: NSString = tempText as NSString
        editText = editText.replacingOccurrences(of: ".", with: "-") as NSString
        editText = editText.replacingOccurrences(of: "/", with: "-") as NSString
        editText = editText.replacingOccurrences(of: " ", with: "-") as NSString
        editText = editText.replacingOccurrences(of: "JAN", with: "01") as NSString
        editText = editText.replacingOccurrences(of: "FEB", with: "02") as NSString
        editText = editText.replacingOccurrences(of: "MAR", with: "03") as NSString
        editText = editText.replacingOccurrences(of: "APR", with: "04") as NSString
        editText = editText.replacingOccurrences(of: "MAY", with: "05") as NSString
        editText = editText.replacingOccurrences(of: "JUN", with: "06") as NSString
        editText = editText.replacingOccurrences(of: "JUL", with: "07") as NSString
        editText = editText.replacingOccurrences(of: "AUG", with: "08") as NSString
        editText = editText.replacingOccurrences(of: "SEP", with: "09") as NSString
        editText = editText.replacingOccurrences(of: "OCT", with: "10") as NSString
        editText = editText.replacingOccurrences(of: "NOV", with: "11") as NSString
        editText = editText.replacingOccurrences(of: "DEC", with: "12") as NSString
        
        var resultText = editText as String
        resultText = resultText.westernArabicNumeralsOnly
        return resultText
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
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    let picker = UIImagePickerController()
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera() {
//        picker.sourceType = .camera
//        present(picker, animated: false, completion: nil)
        print("BH")
        let captureVC = ViewController()
        self.navigationController?.pushViewController(captureVC, animated: true)
    
    }
    
    
    @IBOutlet weak var dismissToFirst: UIBarButtonItem!
    
    
    
    @IBAction func addAnImage(_ sender: Any) {
        let alert = UIAlertController(title: "어디서 사진을 가져올까", message: "골라줘", preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
        }
        
        let camera = UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera() // 이거를 captureviewcontroller꺼낼수 있도록
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            addImage.image = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
