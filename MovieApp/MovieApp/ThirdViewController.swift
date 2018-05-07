//
//  ThirdViewController.swift
//  MovieApp
//
//  Created by Kevin van Helden on 23/02/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var sentence: UILabel!
    
    var color: Int = 0
    var text: String = ""
    
    @IBAction func lightSkin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if color == 0{
            view.backgroundColor = .white
        }else{
            view.backgroundColor = .black
            sentence.textColor = .red
        }
        sentence.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
