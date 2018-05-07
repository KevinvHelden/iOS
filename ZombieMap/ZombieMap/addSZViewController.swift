//
//  addSZViewController.swift
//  ZombieMap
//
//  Created by Kevin van Helden on 13/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit
import MapKit

class addSZViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    var safeLocations: [safeLocation] = []
    
    // MARK: Actions
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func appendNewLocation(){
        let name = nameTextField.text
        let latitude = Double (latitudeTextField.text!)
        let longitude = Double (longitudeTextField.text!)
        let newLocation = safeLocation(title: name!, coordinate: CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!))
        safeLocations.append(newLocation)
    }
    
    @IBAction func save(_ sender: Any) {
        appendNewLocation()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
