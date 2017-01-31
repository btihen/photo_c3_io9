//
//  PhotoViewController.swift
//  Filterer
//
//  Created by Bill Tihen on 31.01.17.
//  Copyright © 2017 UofT. All rights reserved.
//

import UIKit

class RecoveredPhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let flickrImages = [
        "sample",
        "scenery",
        "landscape"
    ]
    
    var choices = [String]()
    var searchURL:  String?
    var searchTerm: String?
    var urlSession: NSURLSession!
    
    var valueToPass:String!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchURL  = NSUserDefaults.standardUserDefaults().stringForKey("SearchURL")
        searchTerm = NSUserDefaults.standardUserDefaults().stringForKey("SearchTerm")
        tableView.delegate     = self
        tableView.dataSource   = self
        
        // eventually flickr results
        choices = []
        // will populate with real data at some point
        choices = flickrImages
        
        print( "LIST TO CHOOSE FROM " )
        print( choices )
        
        print( "Flickr Photo Controller")
        if searchTerm != nil &&  searchURL != nil {
            print( searchTerm! )
            print( searchURL! )
        } else {
            print( "Should have search term and URL - crash soon" )
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    // keeps track of which cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath )
        // Configure the cell...
        // be sure flickr info is in choices!
        cell.textLabel?.text = "Photo of " + choices[indexPath.row]
        cell.imageView?.image = UIImage( named: choices[indexPath.row] )
        return cell
    }
    
    // next two methods involving passing methods ideas (with some modifications)
    // http://stackoverflow.com/questions/8130600/use-didselectrowatindexpath-or-prepareforsegue-method-for-uitableview
    // and some ideas from 
    // http://stackoverflow.com/questions/28430663/send-data-from-tableview-to-detailview-swift
    
    // delegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // save the new array
        let selectedImage = choices[indexPath.row]
        valueToPass = selectedImage
        print( "FLICKR IMAGE SELECTED -- " + selectedImage )
        // initialize new view controller and cast it as your view controller
        valueToPass = selectedImage
        
        // http://stackoverflow.com/questions/32051629/passing-variables-between-storyboards-without-segues-swift
        //        let storyboard = UIStoryboard(name: "PhotoInspector", bundle: nil)
        //        let newController = storyboard.instantiateViewControllerWithIdentifier("PhotoInspectViewController") as! PhotoInspectViewController
        //        newController.passedValue = valueToPass
        // self.presentViewController( newController, animated: true, completion: nil )
        
        performSegueWithIdentifier("PhotoInspectorSegue", sender: self)
        
        // http://stackoverflow.com/questions/11862883/whose-view-is-not-in-the-window-hierarchy
        //performSegueWithIdentifier("LoadNewDefaultImage", sender: self)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Your flickr image has been saved to your photo album.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        print( "Segue OVERRIDE" )
        if (segue.identifier == "PhotoInspectorSegue") {
            let selectedRow = self.tableView.indexPathForSelectedRow?.row
            let valueToPass = flickrImages[selectedRow!]
            print( "PASSING VALUE -- " + valueToPass )
            // initialize new view controller and cast it as your view controller
            let newViewController = segue.destinationViewController as! ViewController
            newViewController.passedValue = valueToPass
        }
    }
}
