//
//  profileViewController.swift
//  Travel and Eat App
//
//  Created by Yusuf Eren Bulam on 16.04.2023.
//

import UIKit
import Parse

class MyTravelsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  

    @IBOutlet weak var tableViewCell: UITableView!
    
    var placeNameArrey = [String]()
    var placeIdArray = [String]()
    var selectedPlaceId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromParse()
        
        tableViewCell.delegate = self
        tableViewCell.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    // funcs
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyPlacesVC" {
            let destinationVC = segue.destination as? MyPlacesVC
            destinationVC?.chosenPlaceId = selectedPlaceId
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "MyPlacesVC", sender: nil)
    }
    
    func getDataFromParse() {
     let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error.debugDescription)
            } else {
                if objects != nil {
                    self.placeNameArrey.removeAll(keepingCapacity: false)
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let placeName = object.object(forKey: "Name") as? String {
                            if let placeID = object.objectId {
                                self.placeNameArrey.append(placeName)
                                self.placeIdArray.append(placeID)
                            }
                        }
                    }
                }
                self.tableViewCell.reloadData()
                print(self.selectedPlaceId)
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArrey.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArrey[indexPath.row]
        return cell
    }

    func makeAlert(titleInput:String,messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Error", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
  }

