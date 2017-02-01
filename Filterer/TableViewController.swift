//
//  TableViewController.swift
//  Filterer
//
//  Created by Bill Tihen on 29.01.17.
//  Copyright © 2017 UofT. All rights reserved.
//

import UIKit
import Foundation

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var searchURL:   String?
    var searchTerm:  String?
    var valueToPass: String!
    //var allLinks = [String]()
    var sortedLinks = NSUserDefaults.standardUserDefaults().objectForKey("Links") as? [String] ?? [String]()
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var lastSearchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var termTextField: UITextField!
    
    let defaults = NSUserDefaults.standardUserDefaults()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //print( "TABLE VIEW CONTROLLER" )
        // diable the last search button if there is no last searched terms
        searchURL  = NSUserDefaults.standardUserDefaults().stringForKey("SearchURL")
        searchTerm = NSUserDefaults.standardUserDefaults().stringForKey("SearchTerm")
        if searchTerm == nil || searchURL == nil {
            lastSearchButton.enabled = false
        } else {
            lastSearchButton.enabled = true
        }
        // assign data source -- state where the data comes from
        tableView.delegate     = self
        tableView.dataSource   = self
        termTextField.delegate = self
    }
    @IBAction func onAddButton(sender: UIButton) {
        if termTextField.text!.isEmpty {
            //print("empty")
        } else {
            let inputTerm = termTextField.text!
            // lowercase the string -- need foundation
            // http://stackoverflow.com/questions/26245645/swift-uppercasestring-or-lowercasestring-property-replacement
            var searchTerm = inputTerm.lowercaseString
            // remove space and replace with _
            // http://stackoverflow.com/questions/27963111/how-to-replace-string-into-string-in-swift
            searchTerm = (searchTerm as NSString).stringByReplacingOccurrencesOfString(" ", withString: "_")
            // add new term to the array
            sortedLinks.append( searchTerm )
            // sort the array alphabetically
            // http://stackoverflow.com/questions/36394813/sorting-of-an-array-alphabetically-in-swift
            sortedLinks = sortedLinks.sort { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
            // save the new array
            defaults.setObject(sortedLinks, forKey: "Links")
            // reload the table with the new data
            self.tableView.reloadData()
            // print("New Search Term: ")
            // print( searchTerm )
            // print("New Search List: ")
            // print( sortedLinks )
        }
    }
    
    @IBAction func onClearButton(sender: UIButton) {
        // empty the search list
        // allLinks = ["Built-in Images"]
        sortedLinks = [String]()
        // save the new array
        defaults.setObject(sortedLinks, forKey: "Links")
        // reload the table (with no search tags)
        self.tableView.reloadData()
        
        // print("clear")
        // print("New Search List")
        // print( sortedLinks )
    }
    
    func reloadData() {}
    
    // DATA METHODS
    // how many rows needed
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return allLinks.count
        return sortedLinks.count
    }
    
    // keeps track of which cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        sortedLinks = defaults.objectForKey("Links") as? [String] ?? [String]()
        // allLinks = ["Built-in Images"]
        // allLinks += sortedLinks
        // allLinks = sortedLinks
        //print( sortedLinks )
        let cell = tableView.dequeueReusableCellWithIdentifier("LinkCell", forIndexPath: indexPath )
        // populate cell
        cell.textLabel?.text = sortedLinks[indexPath.row]
        //cell.textLabel?.text = allLinks[indexPath.row]
        return cell
    }
    
    // delegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print( "ROW SELECTED" )
        // save the new array
        // let searchTerm = allLinks[indexPath.row]
        let searchTerm = sortedLinks[indexPath.row]
        let searchURL  = "https://api.flickr.com/services/feeds/photos_public.gne?" + searchTerm + "&format=json&nojsoncallback=1"
        // until I figure out how to pass data between controllers or with segues
        // I will save the data and read it in PhotoViewController!
        defaults.setObject(searchURL,  forKey: "SearchURL")
        defaults.setObject(searchTerm, forKey: "SearchTerm")
        //print( "SAVED LAST SEARCH INFO" )
        // test to see if the last search terms were really saved
        // if so enable the last search button
        let newSearchURL  = defaults.stringForKey("SearchURL")
        let newSearchTerm = defaults.stringForKey("SearchTerm")
        if newSearchTerm == nil || newSearchURL == nil {
            lastSearchButton.enabled = false
        } else {
            lastSearchButton.enabled = true
        }
        // print( searchURL )
        // print(sortedLinks[indexPath.row])
        // print( searchTerm )
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        //print( "Starting SEGUE" )
        if (segue.identifier == "CellSearchSegue") {
            //print( "CELL SELECTED SEGUE" )
            let selectedRow = self.tableView.indexPathForSelectedRow?.row
            valueToPass = sortedLinks[selectedRow!]
            let nextController = segue.destinationViewController as! PhotoViewController
            nextController.valuePassed = valueToPass
        }
        if  (segue.identifier == "LastSearchSegue") {
            //print( "LAST SELECTED SEGUE" )
            valueToPass = defaults.stringForKey("SearchTerm")
            let nextController = segue.destinationViewController as! PhotoViewController
            nextController.valuePassed = valueToPass
        }
    }
}
