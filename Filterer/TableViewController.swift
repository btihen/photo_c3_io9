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
    
    var searchTerm: String?
    var sortedLinks = NSUserDefaults.standardUserDefaults().objectForKey("Links") as? [String] ?? [String]()
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var termTextField: UITextField!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // assign data source -- state where the data comes from
        tableView.delegate     = self
        tableView.dataSource   = self
        termTextField.delegate = self
        
    }
    @IBAction func onAddButton(sender: UIButton) {
        if termTextField.text!.isEmpty {
            print("empty")
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
            
            print("New Search Term: ")
            print( searchTerm )
            print("New Search List: ")
            print( sortedLinks )
        }
    }
    
    @IBAction func onClearButton(sender: UIButton) {
        print("clear")
        sortedLinks = [String]()
        print("New Search List")
        print( sortedLinks )
        defaults.setObject(sortedLinks, forKey: "Links")
        self.tableView.reloadData()
    }
    
    // http://stackoverflow.com/questions/37096587/check-textfield-has-value-before-redirecting-to-another-view-swift
    // learn how to properly identify seques in order to use this - examples kept failing
    //
//    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
//        
//        if termTextField.text!.isEmpty {
//            print("empty")
//            return false
//        } else{
//            print(termTextField.text)
//            let searchTerm = termTextField.text!
//            sortedLinks.append( searchTerm )
//            print("New Search Term: ")
//            print( searchTerm )
//            print("New Search List")
//            print( sortedLinks )
//            defaults.setObject(sortedLinks, forKey: "Links")
//            self.tableView.reloadData()
//            let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?" + searchTerm + "&format=json&nojsoncallback=1"
//            print( urlString )
//            return true
//        }
//    }
    
    func reloadData() {}
    
    // DATA METHODS
    // how many rows needed
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sortedLinks.count
    }
    
    // keeps track of which cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        sortedLinks = defaults.objectForKey("Links") as? [String] ?? [String]()
        let cell = tableView.dequeueReusableCellWithIdentifier("LinkCell", forIndexPath: indexPath )
        // populate cell
        cell.textLabel?.text = sortedLinks[indexPath.row]
        return cell
    }
    
    // delegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(sortedLinks[indexPath.row])
        let searchTerm = sortedLinks[indexPath.row]
        print( searchTerm )
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?" + searchTerm + "&format=json&nojsoncallback=1"
        print( urlString )
    }
    
}
