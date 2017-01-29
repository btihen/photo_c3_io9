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

    // data collection
    let filters = [
        "red",
        "blue",
        "green",
        "yellow",
        "salmon",
        "black",
        "pink",
        "dark grey",
        "grey",
        "light grey",
        "lemon",
        "lime",
        "aqua",
        "red",
        "blue",
        "green",
        "yellow",
        "salmon",
        "black",
        "pink",
        "dark grey",
        "grey",
        "light grey",
        "lemon",
        "lime",
        "aqua"
    ]

    let links = NSUserDefaults.standardUserDefaults().objectForKey("Links") as? [String] ?? [String]()
    
    // DATA METHODS
    // how many rows needed
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    // keeps track of which cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LinkCell", forIndexPath: indexPath )
        // populate cell
        cell.textLabel?.text = links[indexPath.row]
        return cell
    }
    
    // delegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(links[indexPath.row])
    }
    
}