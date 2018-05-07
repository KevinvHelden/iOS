//
//  profileViewController.swift
//  Carpool Karaoke
//
//  Created by Kevin van Helden on 22/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class profileViewController: UIViewController {
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var visibleLabel: UILabel!
    @IBOutlet weak var driverPassengerLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var docRef: DocumentReference!
    var quoteListener: ListenerRegistration!
    var colRef: CollectionReference!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quoteListener = docRef.addSnapshotListener { (DocumentSnapshot, error) in
            guard let docSnapchot = DocumentSnapshot, (DocumentSnapshot?.exists)! else { return }
            let myData = docSnapchot.data()
            let Name = myData["Name"] as? String ?? ""
            let Genre = myData["Genre"] as? String ?? ""
            let Birthday = myData["Birthday"] as? Date
            let driverPassenger = myData["DriverPassenger"] as? String ?? ""
            
            //Visible bool vertalen naar tekst
            let Visible: String!
            let visibleBool = myData["Visible"] as? Bool
            if visibleBool == true{
                Visible = "Yes"
                self.visibleLabel.textColor = darkGreen
                self.view.layer.cornerRadius = 8
            }else{
                Visible = "No"
                self.visibleLabel.textColor = .red
                self.view.layer.cornerRadius = 8
            }
            
            //bereken het aantal minuten tussen nu en de birthday uit de database
            //hieruit krijg je een negatief getal met fabs zet je dit om in een positief getal
            let Today: Double = fabs((Birthday?.timeIntervalSinceNow)!)
            //met de DateComponentsFormatter zet je minuten om in jaren
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            formatter.allowedUnits = [.year]
            let Age = formatter.string(from: Today)
            
            self.nameLabel.text = (Name)
            self.genreLabel.text = (Genre)
            self.ageLabel.text = Age
            self.visibleLabel.text = (Visible)
            self.driverPassengerLabel.text = (driverPassenger)
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutButton.layer.cornerRadius = 10.0
        docRef = Firestore.firestore().document("Users/\(UserID!)")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        quoteListener.remove()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "logOut", sender: nil)
            print ("Succesful logout!")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
