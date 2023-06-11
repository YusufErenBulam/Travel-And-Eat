//
//  placeModel.swift
//  Travel and Eat App
//
//  Created by Yusuf Eren Bulam on 18.04.2023.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeComment = ""
    var placeType = ""
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init() {}
}

class BiographyModel {
    
    static let sharedInstance2 = BiographyModel()
    
    var Name = ""
    var Biography = ""
    var Image = UIImage()
    
    private init() {}
    
}

