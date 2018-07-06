//
//  TesseractOCRTableViewController.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 9..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit
import TesseractOCR

class TesseractOCRTableViewController: UITableViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var topMarginConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // IBAction methods
    
    @IBAction func takePhoto(_ sender: Any) {
        view.endEditing(true)
        presentImagePicker()
    }
    
    
    // Tesseract OCR 문자인식
    func performImageRecognition(_ image: UIImage) {
        
        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.pageSegmentationMode = .auto
            tesseract.image = image.g8_blackAndWhite()
            tesseract.recognize()
            let resultText = censorText(text: tesseract.recognizedText)
            
            textView.text = resultText
        }
    }
    
    func censorText(text: String?) -> String {
        guard let tempText = text else {
            return "FAIL"
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
        
        let resultText = editText as String
        return resultText
    }
    
    // move the view so that the first responders aren't hidden
    func moveViewUp() {
        if topMarginConstraint.constant != 0 {
            return
        }
        topMarginConstraint.constant -= 135
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func moveViewDown() {
        if topMarginConstraint.constant == 0 {
            return
        }
        topMarginConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}


// UINavigationControllerDelegate
extension TesseractOCRTableViewController : UINavigationControllerDelegate {
}

// UIImagePickerControllerDelegate
extension TesseractOCRTableViewController : UIImagePickerControllerDelegate {
    func presentImagePicker() {
        
        let imagePickerActionSheet = UIAlertController(title: "어디서 사진을 가져올까",
                                                       message: "골라줘", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "카메라",
                                             style: .default) { (alert) -> Void in
                                                let imagePicker = UIImagePickerController()
                                                imagePicker.delegate = self
                                                imagePicker.sourceType = .camera
                                                self.present(imagePicker, animated: true)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        let libraryButton = UIAlertAction(title: "사진앨범",
                                          style: .default) { (alert) -> Void in
                                            let imagePicker = UIImagePickerController()
                                            imagePicker.delegate = self
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker, animated: true)
        }
        imagePickerActionSheet.addAction(libraryButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        imagePickerActionSheet.addAction(cancelButton)
        
        present(imagePickerActionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {

        if let selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let scaledImage = selectedPhoto.scaleImage(640) {

            dismiss(animated: true, completion: {
                self.performImageRecognition(scaledImage)
            })
        }
    }
}

// MARK: - UIImage extension
extension UIImage {
    func scaleImage(_ maxDimension: CGFloat) -> UIImage? {

        var scaledSize = CGSize(width: maxDimension, height: maxDimension)

        if size.width > size.height {
            let scaleFactor = size.height / size.width
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            let scaleFactor = size.width / size.height
            scaledSize.width = scaledSize.height * scaleFactor
        }

        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage
    }
}

