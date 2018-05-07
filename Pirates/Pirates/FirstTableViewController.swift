//
//  FirstTableViewController.swift
//  Pirates
//
//  Created by Kevin van Helden on 02/03/2018.
//  Copyright © 2018 Kevin van Helden. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {
    
    class Pirate
    {
        var name:String?
        var life:String?
        var countryOfOrigin:String?
        var comments:String?
    }
    
    var pirates = [Pirate]()
    
    
    func loadJsonData()
    {
        let url = NSURL(string: "https://i886625.venus.fhict.nl/pirates.json")
        let request = NSURLRequest(url: url! as URL)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            do
            {
                if (error == nil)
                {
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)

                    self.parseJsonData(rawData: jsonObject) // Will be explained later
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                else
                {
                    print("Error with http request")
                }
                    
            }
            catch
            {
                print("Error serializing JSON data")
            }
        }
        dataTask.resume();
    }
    
    func parseJsonData(rawData:Any)
    {
        if let jsonArray = rawData as? [[String:Any]]
        {
            for jsonDict in jsonArray
            {

                let newPirate = Pirate()

                if let name = jsonDict["name"] as? String
                {
                    newPirate.name = name
                }

                if let life = jsonDict["life"] as? String
                {
                    newPirate.life = life
                }
                if let country = jsonDict["country_of_origin"] as? String
                {
                    newPirate.countryOfOrigin = country
                }

                if let comments = jsonDict["comments"] as? String
                {
                    newPirate.comments = comments
                }
                
                pirates.append(newPirate)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJsonData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return pirates.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath)
        let index = indexPath.item
        cell.textLabel?.text = pirates[index].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! ViewController
        
        //gets the selected row
        let indexPath = tableView.indexPathForSelectedRow
        //saves the index of the selected row in a variable
        let path = indexPath![1]
        
        destination.Steve.name = pirates[path].name
        destination.Steve.life = pirates[path].life
        destination.Steve.countryOfOrigin = pirates[path].countryOfOrigin
        destination.Steve.comments = pirates[path].comments

    }

}
