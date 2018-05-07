//
//  firstTableViewController.swift
//  ZombieMap
//
//  Created by Kevin van Helden on 09/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit
import MapKit

class firstTableViewController: UITableViewController {
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var safeLocations: [safeLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return safeLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "safeZone", for: indexPath)
        let index = indexPath.item
        cell.textLabel?.text = safeLocations[index].title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let modalView = segue.destination as! addSZViewController
        modalView.safeLocations = safeLocations
    }
}
