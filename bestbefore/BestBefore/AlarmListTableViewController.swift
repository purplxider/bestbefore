//
//  AlarmListTableViewController.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 7..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
    
    
    var alarms:[Alarm] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var alarm1 = Alarm(time: "08:30 AM", mode: "소리")
        var alarm2 = Alarm(time: "06:30 PM", mode: "진동")
        
        alarms.append(alarm1)
        alarms.append(alarm2)
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
        return alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarm", for: indexPath) as! AlarmTableViewCell
        
        var alarm = alarms[indexPath.row]
        
        cell.AlarmTime.text = "\(alarm.time)"
        
        cell.AlarmMode.text = "\(alarm.mode)"
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let createAlarmVC = segue.destination as? AlarmViewController
        if let createAlarm = createAlarmVC {
            createAlarm.delegate = self
        }
    }
    
    
    
    
}
