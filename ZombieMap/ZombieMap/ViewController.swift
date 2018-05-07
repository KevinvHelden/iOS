//
//  ViewController.swift
//  ZombieMap
//
//  Created by Kevin van Helden on 09/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //MARK: Properties
    
    let LocationManager = CLLocationManager()
    //array of safe locations
    var safeLocations = [safeLocation]()
    //array of zombies
    var zombies = [Zombie]()
    //the mapview outlet
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //standard maptype
        mapView.mapType = MKMapType.standard
        
        mapView.delegate = self
        
        LocationManager.delegate = self
        LocationManager.requestWhenInUseAuthorization()
        
        LocationManager.startUpdatingLocation()
        
        //safelocations filled with all the initial safe locations
        safeLocations = [Verkhoyansk, Fraser, Amsterdam, Hell, Barrow, Oymyakon, Tilburg]
        //zombielocations
        zombies = [zombie, zombie2]
        }
    
    override func viewWillAppear(_ animated: Bool) {
        
        mapView.reloadInputViews()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //last known location
        let newLocation = locations[0]
        
        //your current location filled in constructor
        let mylocation = myLocation(title: "My Location", coordinate: newLocation.coordinate, info: "Kevin van Helden" )
        
        //set the view centered of your location
        mapView.setCenter(mylocation.coordinate, animated: true)
        
        //add your annotation
        mapView.addAnnotation(mylocation)
        
        for items in safeLocations{
            mapView.addAnnotation(items)
        }
        
        for items in zombies{
            mapView.addAnnotation(items)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tableView = segue.destination as! firstTableViewController
        tableView.safeLocations = safeLocations
    }
}


