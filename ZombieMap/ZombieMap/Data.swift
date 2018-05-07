//
//  Data.swift
//  ZombieMap
//
//  Created by Kevin van Helden on 13/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import Foundation
import MapKit

//MARK: Contrsuctors

//constructor of safe locations
class safeLocation: NSObject, MKAnnotation{
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

//constructor of zombies
class Zombie: NSObject, MKAnnotation{
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

//constructor of my location
class myLocation: NSObject, MKAnnotation{
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}

//create initial safe locations
var Verkhoyansk = safeLocation(title: "Verkhoyansk", coordinate: CLLocationCoordinate2D(latitude: 67.550592, longitude: 133.399340))
var Fraser = safeLocation(title: "Fraser", coordinate: CLLocationCoordinate2D(latitude: 39.944987, longitude: -105.817232))
var Amsterdam = safeLocation(title: "Amsterdam", coordinate: CLLocationCoordinate2D(latitude: 52.370215, longitude: 4.895167))
var Hell = safeLocation(title: "Hell", coordinate: CLLocationCoordinate2D(latitude: 63.445171, longitude: 10.905217))
var Barrow = safeLocation(title: "Barrow", coordinate: CLLocationCoordinate2D(latitude: 71.290556, longitude: -156.788611))
var Oymyakon = safeLocation(title: "Oymyakon", coordinate: CLLocationCoordinate2D(latitude: 63.464138, longitude: 142.773727))
var Tilburg = safeLocation(title: "Tilburg", coordinate: CLLocationCoordinate2D(latitude: 51.585252, longitude: 5.056375))

//create initial zombie locations
var zombie =  Zombie(title: "zombie", coordinate: CLLocationCoordinate2D(latitude: 51.5719149, longitude: 4.768323000000009))
var zombie2 =  Zombie(title: "zombie", coordinate: CLLocationCoordinate2D(latitude: 51.44062087766546, longitude: 5.448754120636522))
