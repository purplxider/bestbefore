//
//  TesseractOCRViewController.swift
//  BestBefore
//
//  Created by CAUADC on 2018. 2. 8..
//  Copyright © 2018년 0. All rights reserved.
//

import UIKit
import TesseractOCR

class TesseractOCRViewController: UIViewController {
    
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
        
        if let tesseract = G8Tesseract(language: "eng+kor") {
            tesseract.pageSegmentationMode = .auto
            tesseract.image = image.g8_blackAndWhite()
            tesseract.recognize()
            textView.text = tesseract.recognizedText
        }
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
extension TesseractOCRViewController: UINavigationControllerDelegate {
}

// UIImagePickerControllerDelegate
extension TesseractOCRViewController: UIImagePickerControllerDelegate {
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


//    @IBOutlt weak var textView: UITextView!
//
//    let picker = UIImagePickerController()
//
//    func openLibrary() {
//        picker.sourceType = .photoLibrary
//        present(picker, animated: false, completion: nil)
//    }
//
//    func openCamera() {
//        picker.sourceType = .camera
//        present(picker, animated: false, completion: nil)
//    }
//
//    @IBAction func addAnImage(_ sender: Any) {
//        let alert = UIAlertController(title: "어디서 사진을 가져올까", message: "골라줘", preferredStyle: .actionSheet)
//
//        let library = UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
//        }
//
//        let camera = UIAlertAction(title: "카메라", style: .default) { (action) in
//            self.openCamera()
//        }
//
//        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//
//        alert.addAction(library)
//        alert.addAction(camera)
//        alert.addAction(cancel)
//
//        present(alert, animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
//            addImage.image = image
//            print(info)
//        }
//        dismiss(animated: true, completion: nil)
//    }
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        picker.delegate = self
//
//        if let tesseract = G8Tesseract(language:"eng") {
//            tesseract.delegate = self
//            tesseract.image = UIImage(named: "testImage1")?.g8_blackAndWhite()
//            tesseract.recognize()
//
//            textView.text = tesseract.recognizedText
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }
//
//
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func progressImageRecognition(for tesseract : G8Tesseract!) {
//        print("Recognition Progress\(tesseract.progress) %")
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}

