//
//  D-dayTableViewController.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 1..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit

class D_dayTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CropViewControllerDelegate {
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage) {
    }
    
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage, transform: CGAffineTransform, cropRect: CGRect) {
    }
    
    func cropViewControllerDidCancel(_ controller: CropViewController) {
        
    }
    

    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if FileManager.default.fileExists(atPath: dataCenter.filePath) {
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: dataCenter.filePath) as? [Food] {
                dataCenter.foodArray = unarchArray
            }
        } else {
            var food1 = Food(name: nil, date: "2018-02-02 ", dDay: 10, foodImage: #imageLiteral(resourceName: "milk"), foodColor: UIColorFromRGB(rgbValue: 0xFFD1D1))
            var food2 = Food(name: nil, date: "2018-02-06", dDay: 6, foodImage: #imageLiteral(resourceName: "food2"), foodColor: UIColorFromRGB(rgbValue: 0xFEFFD1))
            var food3 = Food(name: nil, date: "2018-02-12", dDay: 0, foodImage: #imageLiteral(resourceName: "eggs"), foodColor: UIColorFromRGB(rgbValue: 0xD1FFD3))
            var food4 = Food(name: nil, date: "2018-02-15", dDay: -3, foodImage: #imageLiteral(resourceName: "meat"), foodColor: UIColorFromRGB(rgbValue: 0xD1FFD3))
            var food5 = Food(name: nil, date: "2018-02-20", dDay: -8, foodImage: #imageLiteral(resourceName: "sweetcorn"), foodColor: UIColorFromRGB(rgbValue: 0xD1FFD3))
            
            
            dataCenter.foodArray.append(food1)
            dataCenter.foodArray.append(food2)
            dataCenter.foodArray.append(food3)
            dataCenter.foodArray.append(food4)
            dataCenter.foodArray.append(food5)
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        dataCenter.foodArray = dataCenter.foodArray.sorted(by: {$0.dDay > $1.dDay})
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataCenter.foodArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath) as! D_DayTableViewCell
        
        
        var food = dataCenter.foodArray[indexPath.row]
        
        
        
        cell.foodImage.image = food.foodImage
        
        cell.dateLabel.text = "유통기한 : \(food.date)"
        
        
        if food.dDay < -2 {
            cell.dDayLabel.text = "\(-food.dDay)일 남았습니다."
        } else if food.dDay == 0 {
            cell.dDayLabel.text = "오늘까지 드세요!"
        } else if food.dDay < 0{
            cell.dDayLabel.text = "얼마 남지 않았습니다."
        } else {
                cell.dDayLabel.text = "\(food.dDay)일 지났습니다. 버리세요."
        }
        
        
        cell.backgroundColor = food.foodColor
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            dataCenter.foodArray.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
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
    
    
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        var itemToMove = dataCenter.foodArray[fromIndexPath.row]
        dataCenter.foodArray.remove(at:fromIndexPath.row)
        dataCenter.foodArray.insert(itemToMove, at: to.row)
     
     }
    
    
    
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return false
     }
    
    @IBAction func deleteButton(_ sender: Any) {
        self.isEditing = !self.isEditing
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            let selectedRow = indexPath.row
            let vc = segue.destination as? DetailTableViewController
            vc?.food = dataCenter.foodArray[selectedRow]
        }
        
//        let createVC = segue.destination as? AddTableViewController
//        if let create = createVC {
//            create.delegate = dataCenter
//
//        }
        
    }
    
    
    
    func manualAddition() {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "manualAdd")
        present(nextView, animated: true, completion: nil)
    }

    func automaticAddition() {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "automaticAdd")
        present(nextView, animated: true, completion: nil)
    }
    
    func showCamera() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .camera
        present(controller, animated: true, completion: nil)
    }
    
    
    
    
}

