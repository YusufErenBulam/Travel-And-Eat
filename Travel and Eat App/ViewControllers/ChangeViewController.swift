//
//  ChangeViewController.swift
//  Travel and Eat App
//
//  Created by Yusuf Eren Bulam on 25.05.2023.
//

import UIKit
import Parse

class ChangeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var ChangeImage: UIImageView!
    
    @IBOutlet weak var ChangeNameTText: UITextField!
    @IBOutlet weak var ChangeBiographyText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ChangeImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosenImage))
        ChangeImage.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        let BiographyModel = BiographyModel.sharedInstance2
        BiographyModel.Name = ChangeNameTText.text!
        BiographyModel.Biography = ChangeBiographyText.text!
        BiographyModel.Image = UIImage()
        
        
        let object2 = PFObject(className: "Biography")
        object2["Name"] = BiographyModel.Name
        object2["Biography"] = BiographyModel.Biography
        
        if let imageData = BiographyModel.Image.jpegData(compressionQuality: 0.5){
            object2["Image"] = PFFileObject(name: "image.jpg", data: imageData)
        }
        
        object2.saveInBackground { success, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "??", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Error", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                self.dismiss(animated: true)
            }
            
        }
        
    }
    
    // MARK: - FUNCS
    
   
       @objc func choosenImage() {
        let pickerController = UIImagePickerController()
           pickerController.delegate = self
           pickerController.sourceType = .photoLibrary
           present(pickerController, animated: true)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ChangeImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    
}
