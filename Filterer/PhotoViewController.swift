//
//  PhotoViewController.swift
//  Filterer
//
//  Created by Bill Tihen on 31.01.17.
//  Copyright © 2017 UofT. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let images = [
        "sample",
        "scenery",
        "landscape"
    ]
    
    var valueToPass:String!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate     = self
        tableView.dataSource   = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    // keeps track of which cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath )
        // Configure the cell...
        cell.textLabel?.text = "Photo of " + images[indexPath.row]
        cell.imageView?.image = UIImage( named: images[indexPath.row] )
        return cell
    }
    
    // next two methods involving passing methods ideas (with some modifications)
    // http://stackoverflow.com/questions/8130600/use-didselectrowatindexpath-or-prepareforsegue-method-for-uitableview
    // and some ideas from 
    // http://stackoverflow.com/questions/28430663/send-data-from-tableview-to-detailview-swift
    
    // delegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {        // save the new array
        let selectedImage = images[indexPath.row]
        print( "IMAGE SELECTED for Transition -- " + selectedImage )
        NSUserDefaults.standardUserDefaults().setObject(selectedImage, forKey: "DefaultImage")
        valueToPass = selectedImage
        performSegueWithIdentifier("LoadNewDefaultImage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        print( "Segue OVERRIDE" )
        if (segue.identifier == "LoadNewDefaultImage") {
            let selectedRow = self.tableView.indexPathForSelectedRow?.row
            let valueToPass = images[selectedRow!]
            print( "PASSING VALUE -- " + valueToPass )
            // store the new default value
            NSUserDefaults.standardUserDefaults().setObject(valueToPass, forKey: "DefaultImage")
            // initialize new view controller and cast it as your view controller
            let imageViewController = segue.destinationViewController as! ViewController
            imageViewController.passedValue = valueToPass
        }
    }
}
