//
//  D-dayTableViewController.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 1..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit

class D_dayTableViewController: UITableViewController {
    

    
    var foods:[Food] = []
    var sortedFoods:[Food] = []
    
    
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
        
        var food1 = Food(date: "2018. 01. 02", dDay: -7, foodImage: #imageLiteral(resourceName: "food1"), foodColor: UIColorFromRGB(rgbValue: 0xFFD1D1))
        var food2 = Food(date: "2018. 01. 08", dDay: 1, foodImage: #imageLiteral(resourceName: "food2"), foodColor: UIColorFromRGB(rgbValue: 0xFEFFD1))
        var food3 = Food(date: "2018. 01. 15", dDay: 10, foodImage: #imageLiteral(resourceName: "food3"), foodColor: UIColorFromRGB(rgbValue: 0xD1FFD3))
        var food4 = Food(date: "2018. 01. 02", dDay: -7, foodImage: #imageLiteral(resourceName: "food1"), foodColor: UIColorFromRGB(rgbValue: 0xFFD1D1))
        var food5 = Food(date: "2018. 01. 08", dDay: 1, foodImage: #imageLiteral(resourceName: "food2"), foodColor: UIColorFromRGB(rgbValue: 0xFEFFD1))
        var food6 = Food(date: "2018. 01. 15", dDay: 10, foodImage: #imageLiteral(resourceName: "food3"), foodColor: UIColorFromRGB(rgbValue: 0xD1FFD3))
        
        foods.append(food1)
        foods.append(food2)
        foods.append(food3)
        foods.append(food4)
        foods.append(food5)
        foods.append(food6)
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        sortedFoods = foods.sorted(by: {$0.dDay < $1.dDay})
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
        return foods.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath) as! D_DayTableViewCell
        
        
        var food = sortedFoods[indexPath.row]
        
        
        
        cell.foodImage.image = food.foodImage
        
        cell.dateLabel.text = "유통기한 : \(food.date)"
        
        
        if food.dDay > 2 {
            cell.dDayLabel.text = "\(food.dDay)일 남았습니다."
        } else if food.dDay > 0{
            cell.dDayLabel.text = "얼마 남지 않았습니다."
        } else {
                cell.dDayLabel.text = "\(-food.dDay)일 지났습니다. 버리세요"
        }
        
        
        cell.backgroundColor = food.foodColor
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            foods.remove(at: indexPath.row)
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
        
        var itemToMove = foods[fromIndexPath.row]
        foods.remove(at:fromIndexPath.row)
        foods.insert(itemToMove, at: to.row)
     
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
            let vc = segue.destination as? DetailViewController
            vc?.food = sortedFoods[selectedRow]
        }
        
        let createVC = segue.destination as? AddTableViewController
        if let create = createVC {
            create.delegate = self
        
        }
        
    }
    
    
    
}

