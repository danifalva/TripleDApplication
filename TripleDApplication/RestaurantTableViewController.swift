//
//  RestaurantTableViewController.swift
//  TripleDApplication
//
//  Created by Daniela Alvarez  on 4/18/18.
//  Copyright © 2018 Daniela Alvarez Ulloa. All rights reserved.
//

import UIKit
import CoreLocation

class RestaurantTableViewController: UITableViewController, XMLParserDelegate, CLLocationManagerDelegate {
    //MARK: Variables
    var myRestaurant = Array<RestaurantModel>()
    
    var name:String? = nil
    var descrip:String? = nil
    var coordinates:String? = nil
    var latitude:Double? = nil
    var longitude:Double? = nil
    var address:String? = nil
 
    var currentParsingElement:String = ""
    
    //MARK: - Parsing Funcs
    //Link to Source: https://github.com/nimblechapps/XMLParsing_Swift_iOS
    func getXMLDataFromServer(){
        let url = URL(string: "https://www.google.com/maps/d/u/0/kml?mid=1l7NMLMGeWuDozExpiAHk1HkuEd0&forcekml=1")
        
        //Creating data task
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if data == nil {
                print("dataTaskWithRequest error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            let parser = XMLParser(data: data!)
            parser.delegate = self
            parser.parse()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        task.resume()
        
    }
    
    func displayOnUI(){
        for a in myRestaurant {
            print(" ")
            print("Name: " + a.name)
            print("Description: " + a.descrip)
            //print("Coordinates: " + a.coordinates)
            print("latitiude: \(a.latitude)")
            print("longitude: \(a.longitude)")
            
        }
        print("Count: \(myRestaurant.count)")
    }
    
    //MARK:- XML Delegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentParsingElement = elementName
        if elementName == "Response" {
            print("Started parsing...")
        }
    }
    
    func clear() {
        name = nil
        descrip = nil
        coordinates = nil
        latitude = nil
        longitude = nil
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let foundedChar = string.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)
        
        if (!foundedChar.isEmpty) {
            if currentParsingElement == "name" {
                // below is the insert
                if let actualName=name, let actualDescrip = descrip, let actualCoord = coordinates, let actualLat: Double = latitude, let actualLong: Double = longitude {
                    let newElement = RestaurantModel(name: actualName, descrip: actualDescrip, coordinates: actualCoord, latitude: actualLat, longitude: actualLong)
                    myRestaurant.append(newElement)
                }
                clear()
                name = foundedChar
            }
            else if currentParsingElement == "description" {
                descrip = foundedChar
            }
            else if currentParsingElement == "coordinates" {
                coordinates = foundedChar
                let cArray = coordinates?.components(separatedBy: ",")
                latitude = Double(cArray![0])
                longitude = Double(cArray![1])
                
   

            }
            
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Response" {
            print("Ended parsing...")
            
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            // Update UI
            self.displayOnUI()
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    //MARK: - TableView Functions
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getXMLDataFromServer() // <-- Calls Parsing Code'
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myRestaurant.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCellReuseIdentifier", for: indexPath)

        // Configure the cell...
        if let restaurantCell = cell as? RestaurantTableViewCell {
            restaurantCell.nameLabel?.text = myRestaurant[indexPath.row].name
            restaurantCell.descripLabel?.text = myRestaurant[indexPath.row].descrip
            
        }
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //We need to know the following things:
        //- what row was select
        let row = tableView.indexPathForSelectedRow?.row
        
        //- the destination controller
        let destinationVC = segue.destination
        
        if let actualDestVC = segue.destination as? RestuarantDetailViewController {
            actualDestVC.rowNum = row!
            actualDestVC.myRestaurantModel = myRestaurant
        }
        
        
    }
    
    

    

}

