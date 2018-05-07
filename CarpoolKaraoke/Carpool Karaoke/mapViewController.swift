//
//  mapViewController.swift
//  Carpool Karaoke
//
//  Created by Kevin van Helden on 23/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class mapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    //MARK: Properties
    
    @IBOutlet weak var mapView: MKMapView!
    let LocationManager = CLLocationManager()
    var Location = myLocation(title: "", coordinate: CLLocationCoordinate2D (latitude: 0, longitude: 0))
    var Users = [User]()
    
    var docRef: DocumentReference!
    var quoteListener: ListenerRegistration!
    var colRef: CollectionReference!
    var colRef2: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        docRef = Firestore.firestore().document("Users/\(UserID!)")

        mapView.mapType = MKMapType.standard
        mapView.delegate = self
        LocationManager.delegate = self
        LocationManager.requestAlwaysAuthorization()
        self.putUsersInArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        quoteListener = docRef.addSnapshotListener { (DocumentSnapshot, error) in
            guard let docSnapchot = DocumentSnapshot, (DocumentSnapshot?.exists)! else { return }
            let myData = docSnapchot.data()
            let Visible = defaults.bool(forKey: "Visible")
            
            if Visible == true{
                self.LocationManager.startUpdatingLocation()
            }else{
                self.LocationManager.stopUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //sla de locatie op in de database
        //last known location
        let newLocation = locations[0]
        
        let coordinate = newLocation.coordinate
        let dataToSave: [String: Any] = ["coordinateLatitude": coordinate.latitude, "coordinateLongitude": coordinate.longitude]
        
        //updateData ipv setData zodat de rest in het document niet ge-erased wordt
        docRef.updateData(dataToSave){ (error) in
            if let error = error {
                print ("Oh no! Got an error: \(error.localizedDescription)")
            }else{
                print ("Data has been saved!")
            }
        }
 
        //bepaal de locatie vanuit de database
        quoteListener = docRef.addSnapshotListener { (DocumentSnapshot, error) in
            guard let docSnapchot = DocumentSnapshot, (DocumentSnapshot?.exists)! else { return }
            let myData = docSnapchot.data()
            let coordinateLatitude = myData["coordinateLatitude"] as? Double
            let coordinateLongtitude = myData["coordinateLongitude"] as? Double
            let Name = myData["Name"] as? String
            
            //your current location filled in constructor
            self.Location = myLocation(title: Name! + "(You)", coordinate: CLLocationCoordinate2D(latitude: coordinateLatitude!, longitude: coordinateLongtitude!))
        }
    }
    
    func putUsersInArray(){
        
        let documents = Firestore.firestore().collection("Users")
        documents.getDocuments{ (querySnapshot, error) in
            
            if let error = error {
                print("unable to retrieve documents \(error.localizedDescription)")
            } else{
                print("Found documents")
                
                for user in querySnapshot!.documents {
                    let newUser = User(title: "", coordinate: CLLocationCoordinate2D (latitude: 0, longitude: 0), subtitle: "")
                    newUser.title = user.data()["Name"] as? String
                    newUser.Name = newUser.title
                    newUser.Genre = user.data()["Genre"] as? String
                    newUser.DriverPassenger = user.data()["DriverPassenger"] as? String
                    newUser.Visible = user.data()["Visible"] as? Bool
                    newUser.coordinate = CLLocationCoordinate2D (latitude: (user.data()["coordinateLatitude"] as? Double)!, longitude: (user.data()["coordinateLongitude"] as? Double)!)
                    newUser.subtitle = "Genre: \(newUser.Genre!), \(newUser.DriverPassenger!)"
                    let birthday = user.data()["Birthday"] as? Date
                    let Today: Double = fabs((birthday?.timeIntervalSinceNow)!)
                    let formatter = DateComponentsFormatter()
                    formatter.unitsStyle = .full
                    formatter.allowedUnits = [.year]
                    let Age = formatter.string(from: Today)
                    newUser.Age = Age
                    
                    if newUser.Visible == true{
                        self.mapView.addAnnotation(newUser)
                    }else{
                        self.mapView.removeAnnotation(newUser)
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let annotation = MKAnnotationView(annotation: User(title: "", coordinate: CLLocationCoordinate2D (latitude: 0, longitude: 0), subtitle: ""), reuseIdentifier: "User")
        annotation.image = UIImage(named: "Stuur")
        let transform = CGAffineTransform(scaleX: 0.07, y: 0.07)
        annotation.transform = transform
        return annotation
    }
}
