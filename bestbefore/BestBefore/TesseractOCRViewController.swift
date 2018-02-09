//
//  TesseractOCRViewController.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 8..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit
import TesseractOCR

class TesseractOCRViewController: UIViewController, G8TesseractDelegate {
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tesseract = G8Tesseract(language:"eng") {
            tesseract.delegate = self
            tesseract.image = UIImage(named: "testImage1")?.g8_blackAndWhite()
            tesseract.recognize()
            
            textView.text = tesseract.recognizedText
        }
        
    }
    
    func progressImageRecognition(for tesseract : G8Tesseract!) {
        print("Recognition Progress\(tesseract.progress) %")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
