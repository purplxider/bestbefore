//
//  AlarmListTableViewController.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 7..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController{
    
    let delegate = UIApplication.shared.delegate as! AppDelegate

    
    
    @IBAction func deleteButton(_ sender: Any) {
        self.isEditing = !self.isEditing
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        if FileManager.default.fileExists(atPath: dataCenter.alarmFilePath) {
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: dataCenter.alarmFilePath) as? [Alarm] {
                dataCenter.alarmArray = unarchArray
            }
        } else {
            
            var alarm1 = Alarm(time: "08:30", mode: "소리")
            var alarm2 = Alarm(time: "06:30", mode: "진동")
            
            dataCenter.alarmArray.append(alarm1)
            dataCenter.alarmArray.append(alarm2)
        }
        
        
        
        
    }
    

    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
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
        return dataCenter.alarmArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarm", for: indexPath) as! AlarmTableViewCell
        
        var alarm = dataCenter.alarmArray[indexPath.row]
        
        cell.AlarmTime.text = "\(alarm.time)"
        
        cell.AlarmMode.text = "\(alarm.mode)"
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            dataCenter.alarmArray.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        var itemToMove = dataCenter.alarmArray[fromIndexPath.row]
        dataCenter.alarmArray.remove(at:fromIndexPath.row)
        dataCenter.alarmArray.insert(itemToMove, at: to.row)
        
    }
    
    
    
    
    
    
    
    
    
}

