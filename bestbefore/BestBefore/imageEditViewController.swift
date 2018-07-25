//
//  imageEditViewController.swift
//  BestBefore
//
//  Created by MBP05 on 2018. 5. 7..
//  Copyright © 2018년 0. All rights reserved.
//
import UIKit
import TesseractOCR

class imageEditViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CropViewControllerDelegate {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateEditButtonEnabled()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveAndClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openEditor(_ sender: UIBarButtonItem?) {
        guard let image = imageView.image else {
            return
        }
        // Uncomment to use crop view directly
        //        let imgView = UIImageView(image: image)
        //        imgView.clipsToBounds = true
        //        imgView.contentMode = .ScaleAspectFit
        //
        //        let cropView = CropView(frame: imageView.frame)
        //
        //        cropView.opaque = false
        //        cropView.clipsToBounds = true
        //        cropView.backgroundColor = UIColor.clearColor()
        //        cropView.imageView = imgView
        //        cropView.showCroppedArea = true
        //        cropView.cropAspectRatio = 1.0
        //        cropView.keepAspectRatio = true
        //
        //        view.insertSubview(cropView, aboveSubview: imageView)
        
        // Use view controller
        let controller = CropViewController()
        controller.delegate = self
        controller.image = image
        
        
    
        
        
        dataCenter.foodArray.append(Food(name:"test", date: "test", dDay: 1, foodImage: controller.image!, foodColor: UIColorFromRGB(rgbValue: 0xD1FFD3)))
        
        
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonAction(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
            self.showCamera()
        }
        actionSheet.addAction(cameraAction)
        let albumAction = UIAlertAction(title: "Photo Library", style: .default) { action in
            self.openPhotoAlbum()
        }
        actionSheet.addAction(albumAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in }
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .camera
        present(controller, animated: true, completion: nil)
    }
    
    func openPhotoAlbum() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    private func updateEditButtonEnabled() {
        editButton.isEnabled = self.imageView.image != nil
//        dataCenter.foodArray.append(Food(name:"test", date: "test", dDay: 1, foodImage: self.imageView.image! , foodColor: UIColorFromRGB(rgbValue: 0xD1FFD3)))
        
    }
    
    // MARK: - CropView
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage) {
        //        controller.dismissViewControllerAnimated(true, completion: nil)
//           imageView.image = image
        //        updateEditButtonEnabled()
        
        if let tesseract = G8Tesseract(language: "eng+kor"){
            tesseract.pageSegmentationMode = .auto
            tesseract.image = image.g8_blackAndWhite()
            tesseract.recognize()
            let recognizedText = censorText(text: tesseract.recognizedText)
            dataCenter.foodArray.append(Food(name:"cropping test", date: recognizedText, dDay: 1, foodImage: image, foodColor: UIColorFromRGB(rgbValue: 0xD1FFD3)))
        }
//        dataCenter.foodArray.append(Food(name:"cropping test", date: "test", dDay: 1, foodImage: image, foodColor: UIColorFromRGB(rgbValue: 0xD1FFD3)))
        //여기서 크롭된 사진 저장됨 image 변수로
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
        var editNumText = editText.replacingOccurrences(of: "DEC", with: "12") as String
        editNumText = editNumText.westernArabicNumeralsOnly
        
        return editNumText
    }
    
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage, transform: CGAffineTransform, cropRect: CGRect) {
        controller.dismiss(animated: true, completion: nil)
        imageView.image = image
        updateEditButtonEnabled()
    }
    
    func cropViewControllerDidCancel(_ controller: CropViewController) {
        controller.dismiss(animated: true, completion: nil)
        updateEditButtonEnabled()
    }
    
    // MARK: - UIImagePickerController delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        imageView.image = image
        
        dismiss(animated: true) { [unowned self] in
            self.openEditor(nil)
        }
    }
}




