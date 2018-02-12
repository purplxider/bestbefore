//
//  AlarmTableViewCell.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 8..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var AlarmTime: UILabel!
//    @IBOutlet weak var AlarmMode: UILabel!
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        // Initialization code
    //    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
