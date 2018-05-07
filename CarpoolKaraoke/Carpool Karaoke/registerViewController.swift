//
//  registerViewController.swift
//  Carpool Karaoke
//
//  Created by Kevin van Helden on 25/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import MapKit
import CoreLocation

class registerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet weak var musicalPreferenceTextField: UITextField!
    @IBOutlet weak var driverOrPassengerTextField: UITextField!
    let driverPassengerPicker = UIPickerView()
    let genrePicker = UIPickerView()
    var selectedDriverPassenger: String!
    var selectedGenre: String!
    var docRef: DocumentReference!
    let LocationManager = CLLocationManager()
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        //Check if textfields aren't empty
        if let email = emailTextField.text, let pass = passwordTextField.text{
            //Register the user w/Firebase
            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                //Check user isn't nil
                if user != nil{
                    
                    var yourLocation = self.LocationManager.location
                    let Latitude = yourLocation?.coordinate.latitude
                    let Longitude = yourLocation?.coordinate.longitude
                    let name = self.nameTextField.text
                    let genre = self.musicalPreferenceTextField.text
                    let birthday = self.birthdayDatePicker.date
                    let driverPassenger = self.driverOrPassengerTextField.text
                    let visible = true
                    UserID = Auth.auth().currentUser?.uid
                    
                        let dataToSave: [String: Any] = ["Name": name, "Genre": genre, "Birthday": birthday, "DriverPassenger": driverPassenger, "Visible": visible, "coordinateLatitude": Latitude, "coordinateLongitude": Longitude]
                    
                    
                    //als de naam niet leeg is mag je de data updaten
                    if name != ""{
                        self.docRef = Firestore.firestore().document("Users/\(UserID!)")
                        self.docRef.setData(dataToSave){ (error) in
                            if let error = error {
                                print ("Oh no! Got an error: \(error.localizedDescription)")
                            }else{
                                print ("Data has been saved!")
                            }
                        }
                        
                    }
                    
                    //User is found go to home screen
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                }else{
                    //Error check error and show message
                    print(error)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createToolbar()
        createGenrePicker()
        createDriverPassengerPicker()
        registerButton.layer.cornerRadius = 10.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    //if you tap the view the keyboard disappears
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        musicalPreferenceTextField.resignFirstResponder()
        driverOrPassengerTextField.resignFirstResponder()
    }
    
    
    //Genre picker & Driver or Passenger picker
    
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(editProfileViewController.dismissKeyboard))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.barTintColor = .white
        
        musicalPreferenceTextField.inputAccessoryView = toolbar
        nameTextField.inputAccessoryView = toolbar
        driverOrPassengerTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func createGenrePicker(){
        genrePicker.delegate = self
        
        musicalPreferenceTextField.inputView = genrePicker
        genrePicker.backgroundColor = .white
    }
    
    func createDriverPassengerPicker(){
        driverPassengerPicker.delegate = self
        
        driverOrPassengerTextField.inputView = driverPassengerPicker
        driverPassengerPicker.backgroundColor = .white
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == genrePicker{
            return genres[row]
        }else if pickerView == driverPassengerPicker{
            return driverPassenger[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == genrePicker{
            return genres.count
        }else if pickerView == driverPassengerPicker{
            return driverPassenger.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == genrePicker{
            selectedGenre = genres[row]
            musicalPreferenceTextField.text = selectedGenre
        }else if pickerView == driverPassengerPicker{
            selectedDriverPassenger = driverPassenger[row]
            driverOrPassengerTextField.text = selectedDriverPassenger
        }
    }
}
