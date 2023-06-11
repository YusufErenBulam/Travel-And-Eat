//
//  SignUpVC.swift
//  Travel and Eat App
//
//  Created by Yusuf Eren Bulam on 16.04.2023.
//

import UIKit
import Parse

class SignUpVC: UIViewController,UINavigationControllerDelegate {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(backButton))
        
        
        
      }
    @IBAction func signUpButton(_ sender: Any) {
        
        if userNameTextField.text != "" && passwordTextField.text != "" {
            let user = PFUser()
            user.username = userNameTextField.text
            user.password = passwordTextField.text
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error.debugDescription)
                } else {
                    self.performSegue(withIdentifier: "toTabBarFromSignUpVC", sender: nil)
                }
            }
        } else {
            makeAlert(titleInput: "Error", messageInput: "Username / Password")
        }
    }
    
    // funcs
    
    @objc func backButton() {
        self.dismiss(animated: true)
    }
    func makeAlert(titleInput:String,messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Error", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
