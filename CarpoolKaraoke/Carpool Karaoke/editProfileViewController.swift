//
//  editProfileViewController.swift
//  Carpool Karaoke
//
//  Created by Kevin van Helden on 22/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit
import Firebase

class editProfileViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    //MARK: Properties
    @IBOutlet weak var driverPassengerTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var agePicker: UIDatePicker!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var visibilitySwitch: UISwitch!
    let driverPassengerPicker = UIPickerView()
    let genrePicker = UIPickerView()
    var selectedDriverPassenger: String!
    var selectedGenre: String!
    var visible: Bool!
    var docRef: DocumentReference!
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    
    @IBAction func saveButton(_ sender: Any) {
        let name = nameTextField.text
        let genre = genreTextField.text
        let birthday = agePicker.date
        let driverPassenger = driverPassengerTextField.text
        if visibilitySwitch.isOn{
            visible = true
        }else{
            visible = false
        }
        let dataToSave: [String: Any] = ["Name": name, "Genre": genre, "Birthday": birthday, "DriverPassenger": driverPassenger, "Visible": visible]
        
    
        //als de naam niet leeg is mag je de data updaten
        if name != ""{
            docRef.updateData(dataToSave){ (error) in
                if let error = error {
                    print ("Oh no! Got an error: \(error.localizedDescription)")
                }else{
                    print ("Data has been saved!")
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //vul de database data alvast in zodat het niet steeds opnieuw hoeft
        
        docRef.getDocument{ (DocumentSnapshot, error) in
            guard let docSnapshot = DocumentSnapshot, (DocumentSnapshot?.exists)! else { return }
            let myData = docSnapshot.data()
            let Name = myData["Name"] as? String ?? ""
            let Birthday = myData["Birthday"] as? Date
            let Visibility = myData["Visible"] as? Bool
            let Genre = myData["Genre"] as? String ?? ""
            let driverPassenger = myData["DriverPassenger"] as? String ?? ""
            self.nameTextField.text = (Name)
            self.agePicker.setDate(Birthday!, animated: false)
            self.visibilitySwitch.isOn = (Visibility)!
            self.genreTextField.text = (Genre)
            self.driverPassengerTextField.text = (driverPassenger)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createToolbar()
        createGenrePicker()
        createDriverPassengerPicker()

        docRef = Firestore.firestore().document("Users/\(UserID!)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: Genrepicker
    
    
    
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(editProfileViewController.dismissKeyboard))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.barTintColor = .white
        
        genreTextField.inputAccessoryView = toolbar
        nameTextField.inputAccessoryView = toolbar
        driverPassengerTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func createGenrePicker(){
        genrePicker.delegate = self
        genreTextField.inputView = genrePicker
        genrePicker.backgroundColor = .white
    }
    
    func createDriverPassengerPicker(){
        driverPassengerPicker.delegate = self
        
        driverPassengerTextField.inputView = driverPassengerPicker
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
            genreTextField.text = selectedGenre
        }else if pickerView == driverPassengerPicker{
            selectedDriverPassenger = driverPassenger[row]
            driverPassengerTextField.text = selectedDriverPassenger
        }
    }
    
    //if you tap the view the keyboard disappears
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        genreTextField.resignFirstResponder()
        driverPassengerTextField.resignFirstResponder()
    }
}
