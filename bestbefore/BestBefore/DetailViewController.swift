//
//  DetailViewController.swift
//  BestBefore
//
//  Created by cauadc on 2018. 2. 2..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var expiryDateText: UILabel!
    @IBOutlet weak var dDayText: UILabel!
    @IBOutlet weak var expirationStatusText: UILabel!
    
    var food:Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let myFood = food {
            imageView.image = myFood.foodImage
            nameText.text = nil
            expiryDateText.text = myFood.date
            if myFood.dDay < 0 {
                dDayText.text = "D + \(-myFood.dDay)"
                expirationStatusText.text = "종료"
            } else if myFood.dDay < 14{
                dDayText.text = "D - \(myFood.dDay)"
                expirationStatusText.text = "임박"
            } else {
                dDayText.text = "D - \(myFood.dDay)"
                expirationStatusText.text = "안전"
            }
            expirationStatusText.textColor = myFood.foodColor
        }
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
