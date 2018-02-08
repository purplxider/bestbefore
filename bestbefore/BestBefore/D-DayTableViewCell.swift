//
//  D-DayTableViewCell.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 6..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit

class D_DayTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dDayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
