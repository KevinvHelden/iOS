//
//  externalInformation.swift
//  Carpool Karaoke
//
//  Created by Kevin van Helden on 22/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import FirebaseAuth
import Firebase

let genres = ["Choose", "Pop", "Rock", "Blues", "Jazz", "Metal", "R&B", "Indie", "Country", "Rap", "Hardcore", "Hardstyle"]
let driverPassenger = ["Choose", "Passenger", "Driver"]
var UserID = Auth.auth().currentUser?.uid
let defaults = UserDefaults.standard

let darkGreen = UIColor(red: 0.0235, green: 0.7882, blue: 0, alpha: 1.0)
var visible: Bool!

//constructor of my location
class myLocation: NSObject, MKAnnotation{
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    var Name: String?
    var Genre: String?
    var Age: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

class User: NSObject, MKAnnotation{
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    var image: UIImage?
    
    var Name: String?
    var Genre: String?
    var Age: String?
    var DriverPassenger: String?
    var Visible: Bool?
    
    init(title: String, coordinate: CLLocationCoordinate2D, subtitle: String) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
    }
}
