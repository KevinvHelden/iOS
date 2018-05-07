//
//  ViewController.swift
//  MovieApp
//
//  Created by Kevin van Helden on 23/02/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pressed: String = ""
    var chosenColor: Int = 0
    
    @IBAction func lightSkin(_ sender: Any) {
        view.backgroundColor = .white
        pressed = "Your Skin: Light"
        chosenColor = 0
    }
    
    @IBAction func darkSkin(_ sender: Any) {
        view.backgroundColor = .black
        pressed = "Your Skin: Dark"
        chosenColor = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destination = segue.destination as! ThirdViewController
        
        destination.text = pressed
        destination.color = chosenColor
    }


}

