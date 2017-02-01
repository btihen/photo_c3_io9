//
//  StartPhotoViewController.swift
//  Filterer
//
//  Created by Bill Tihen on 31.01.17.
//  Copyright © 2017 UofT. All rights reserved.
//

import UIKit

class StartPhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let builtInImages = [
        "gesar",
        "landscape"
    ]
    
    //var choices = [String]()
    //var searchURL:  String?
    //var searchTerm: String?
    var valueToPass:String!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // searchURL  = NSUserDefaults.standardUserDefaults().stringForKey("SearchURL")
        // searchTerm = NSUserDefaults.standardUserDefaults().stringForKey("SearchTerm")
        tableView.delegate     = self
        tableView.dataSource   = self
        
        //print( "NEW START PHOTO CONTROLLER")
        // if searchTerm != nil && searchURL != nil {
        //    print( searchTerm! )
        //    print( searchURL! )
        //}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return builtInImages.count
    }
    
    // keeps track of which cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StartUpPhoto", forIndexPath: indexPath )
        // Configure the cell...
        cell.textLabel?.text = "Photo of " + builtInImages[indexPath.row]
        cell.imageView?.image = UIImage( named: builtInImages[indexPath.row] )
        // logic might be differnt when loading images from flickr
        return cell
    }
    
    // next two methods involving passing methods ideas (with some modifications)
    // http://stackoverflow.com/questions/8130600/use-didselectrowatindexpath-or-prepareforsegue-method-for-uitableview
    // and some ideas from
    // http://stackoverflow.com/questions/28430663/send-data-from-tableview-to-detailview-swift
    
    // delegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // save the new array
        let selectedImage = builtInImages[indexPath.row]
        //print( "IMAGE SELECTED for Transition -- " + selectedImage )
        NSUserDefaults.standardUserDefaults().setObject(selectedImage, forKey: "DefaultImage")
        valueToPass = selectedImage
        
        // had to disable this since segue was calling this (doesn't like two calls)
        // http://stackoverflow.com/questions/11862883/whose-view-is-not-in-the-window-hierarchy
        //performSegueWithIdentifier("LoadNewDefaultImage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        //print( "Segue OVERRIDE" )
        if (segue.identifier == "LoadNewDefaultImage") {
            let selectedRow = self.tableView.indexPathForSelectedRow?.row
            let valueToPass = builtInImages[selectedRow!]
            //print( "PASSING VALUE -- " + valueToPass )
            // store the new default value
            NSUserDefaults.standardUserDefaults().setObject(valueToPass, forKey: "DefaultImage")
            // initialize new view controller and cast it as your view controller
            let imageViewController = segue.destinationViewController as! ViewController
            imageViewController.passedValue = valueToPass
        }
    }
}
