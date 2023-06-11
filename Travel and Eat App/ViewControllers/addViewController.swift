//
//  addViewController.swift
//  Travel and Eat App
//
//  Created by Yusuf Eren Bulam on 16.04.2023.
//

import UIKit
import Parse
import MapKit

class addViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var mapViewVC: MKMapView!
    var locationManager = CLLocationManager()
    @IBOutlet weak var AddButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapViewVC.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chosenLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3
        mapViewVC.addGestureRecognizer(recognizer)
        
        AddButton.isEnabled = false
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        if nameTextField.text != "" && commentTextField.text != "" && typeTextField.text != "" {
            
            let placeModel = PlaceModel.sharedInstance
            placeModel.placeName = nameTextField.text!
            placeModel.placeComment = commentTextField.text!
            placeModel.placeType = typeTextField.text!
            
            let object = PFObject(className: "Places")
            object["Name"] = placeModel.placeName
            object["Comment"] = placeModel.placeComment
            object["Type"] = placeModel.placeType
            object["Latitude"] = placeModel.placeLatitude
            object["Longitude"] = placeModel.placeLongitude
            
            object.saveInBackground { success, error in
                if error != nil {
                    self.makeAlert(alertInput: "Error", messageInput: error.debugDescription)
                } else {
                    self.tabBarController?.selectedIndex = 2
                }
            }
            
            
        } else {
            makeAlert(alertInput: "Error", messageInput: "eksik bilgi")
        }
    }
    
    
    // funcs
    
    
    @objc func chosenLocation (gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touches = gestureRecognizer.location(in: self.mapViewVC)
            let coordinates = self.mapViewVC.convert(touches, toCoordinateFrom: self.mapViewVC)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = nameTextField.text
            annotation.subtitle = typeTextField.text
            
            self.mapViewVC.addAnnotation(annotation)
            PlaceModel.sharedInstance.placeLatitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.placeLongitude = String(coordinates.longitude)
            
            AddButton.isEnabled = true
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        mapViewVC.setRegion(region, animated: true)
    }
    
    func makeAlert (alertInput:String,messageInput:String){
        let alert = UIAlertController(title: alertInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Error", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
