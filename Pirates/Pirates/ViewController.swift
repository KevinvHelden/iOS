//
//  ViewController.swift
//  Pirates
//
//  Created by Kevin van Helden on 02/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    class Pirate
    {
        var name:String?
        var life:String?
        var countryOfOrigin:String?
        var comments:String?
        
    }
    
    var Steve = Pirate()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var countryOfOriginLabel: UILabel!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var pirateImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameLabel.text = Steve.name
        lifeLabel.text = Steve.life
        countryOfOriginLabel.text = Steve.countryOfOrigin
        commentsTextView.text = Steve.comments
        pirateImage.image = UIImage(named: Steve.name!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

