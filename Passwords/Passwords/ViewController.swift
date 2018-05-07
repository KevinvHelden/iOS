//
//  ViewController.swift
//  Passwords
//
//  Created by Kevin van Helden on 24/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBAction func authWithTouchID(_ sender: Any) {
        let myContext = LAContext()
        let myLocalizedReasonString = "Authenticate to log in"
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    if success {
                        //zonder dispatchqueue laadt de viewcontroller erg traag
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "logIn", sender: self)
                        }
                        
                    } else {
                        self.showAlertController("Touch ID Authentication Failed")
                    }
                }
            } else {
                showAlertController("Touch ID not available")
            }
        } else {
            showAlertController("Not available on your OS version")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
