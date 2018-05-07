//
//  signinViewController.swift
//  Carpool Karaoke
//
//  Created by Kevin van Helden on 25/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class signinViewController: UIViewController {
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var wrongInfoLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var docRef: DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createToolbar()
        logInButton.layer.cornerRadius = 10.0
        registerButton.layer.cornerRadius = 10.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(editProfileViewController.dismissKeyboard))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.barTintColor = .white
        
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func signinButtonTapped(_ sender: Any) {
        
    //Check if textfields aren't empty
    if let email = emailTextField.text, let pass = passwordTextField.text{
            //Sign in the user w/Firebase
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                //Check user isn't nil
                if user != nil{
                    //User is found go to home screen
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                    self.docRef = Firestore.firestore().document("Users/\(UserID!)")
                    self.docRef.getDocument{ (DocumentSnapshot, error) in
                        guard let docSnapshot = DocumentSnapshot, (DocumentSnapshot?.exists)! else { return }
                        let myData = docSnapshot.data()
                        let Visibility = myData["Visible"] as? Bool
                        defaults.set(Visibility, forKey: "Visible")
                    }
                }else{
                    //Error check error and show message
                    print(error)
                    self.wrongInfoLabel.isHidden = false
                }
            }
        }
    }
    
    //if you tap the view the keyboard disappears
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}
