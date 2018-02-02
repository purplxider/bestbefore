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
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        var food1 = Food(date: "2018. 01. 02", dDay: -7, foodImage: #imageLiteral(resourceName: "food1"), foodColor: UIColor.red)
        var food2 = Food(date: "2018. 01. 08", dDay: 1, foodImage: #imageLiteral(resourceName: "food2"), foodColor: UIColor.yellow)
        var food3 = Food(date: "2018. 01. 15", dDay: 10, foodImage: #imageLiteral(resourceName: "food3"), foodColor: UIColor.green)
        
        foods.append(food1)
        foods.append(food2)
        foods.append(food3)
//
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath)

        
        var food = foods[indexPath.row]
        
        cell.imageView?.image = food.foodImage
        cell.textLabel?.text = food.date
        if food.dDay < 0 {
            cell.detailTextLabel?.text = "D + \(-food.dDay)"
        } else {
            cell.detailTextLabel?.text = "D - \(food.dDay)"
        }
        cell.backgroundColor = food.foodColor
        
        return cell
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row
            let vc = segue.destination as? DetailViewController
            vc?.food = foods[selectedRow]
        }
    }
 

}
