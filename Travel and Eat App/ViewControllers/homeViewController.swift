//
//  homeViewController.swift
//  Travel and Eat App
//
//  Created by Yusuf Eren Bulam on 16.04.2023.
//

import UIKit
import Parse

class homeViewController: UIViewController {
    
    @IBOutlet weak var HomeImage: UIImageView!
    @IBOutlet weak var HomeNameLabel: UILabel!
    @IBOutlet weak var HomeBiographyLabel: UILabel!
    var choosenBiographyId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func ChangeButton(_ sender: Any) {
        performSegue(withIdentifier: "ChangeVC", sender: nil)
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Biography")
        query.whereKey("objectId", equalTo: choosenBiographyId)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        let choosenBiographyObject = objects![0]
                        
                        if let Name = choosenBiographyObject.object(forKey: "Name") as? String {
                            self.HomeNameLabel.text = Name
                        }
                        
                        if let Biography = choosenBiographyObject.object(forKey: "Biography") as? String {
                            self.HomeBiographyLabel.text = Biography
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func LogOut(_ sender: Any) {
        PFUser.logOutInBackground { error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error.debugDescription)
        } else {
            self.performSegue(withIdentifier: "toLogOut", sender: nil)
        }
    }
    }
    
    func makeAlert(titleInput:String,messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Error", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
