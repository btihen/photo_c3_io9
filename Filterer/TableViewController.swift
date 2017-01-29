//
//  TableViewController.swift
//  Filterer
//
//  Created by Bill Tihen on 29.01.17.
//  Copyright © 2017 UofT. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // assign data source -- state where the data comes from
        tableView.dataSource = self
        tableView.delegate   = self
    }

    let sortedLinks = NSUserDefaults.standardUserDefaults().objectForKey("Links") as? [String] ?? [String]()
    // let sortedLinks = unsortedLinks.sort { $0 < $1 }
    // let sortedLinks = unsortedLinks.sort { $0.unsortedLinks < $1.unsortedLinks }
    // let sortedLinks = unsortedLinks.sorted { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
    
    // DATA METHODS
    // how many rows needed
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedLinks.count
    }
    
    // keeps track of which cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LinkCell", forIndexPath: indexPath )
        // populate cell
        cell.textLabel?.text = sortedLinks[indexPath.row]
        return cell
    }
    
    // delegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(sortedLinks[indexPath.row])
        let selection = sortedLinks[indexPath.row]
        print( selection )
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?" + selection + "&format=json&nojsoncallback=1"
        print( urlString )
    }
    
}
