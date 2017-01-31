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
        print( "FLICKR PHOTO CONTROLLER" )

        tableView.delegate     = self
        tableView.dataSource   = self
    }

    // didn't help
    // http://stackoverflow.com/questions/26022756/warning-attempt-to-present-on-whose-view-is-not-in-the-window-hierarchy-s
//    func topMostController() -> UIViewController {
//        var topController: UIViewController = UIApplication.sharedApplication().keyWindow!.rootViewController!
//        while (topController.presentedViewController != nil) {
//            topController = topController.presentedViewController!
//        }
//        return topController
//    }
    
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
        //NSUserDefaults.standardUserDefaults().setObject(selectedImage, forKey: "DefaultImage")
        valueToPass = selectedImage
        print( "image selected to pass " + valueToPass )
        // had to disable this since segue was calling this (doesn't like two calls)
        // http://stackoverflow.com/questions/11862883/whose-view-is-not-in-the-window-hierarchy
        // performSegueWithIdentifier("InspectImage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        print( "Segue OVERRIDE" )
        if (segue.identifier == "InspectImage") {
            print( "Inspect Image Segue" )
            let selectedRow = self.tableView.indexPathForSelectedRow?.row
            let valueToPass = images[selectedRow!]
            print( "PASSING VALUE -- " + valueToPass )
            // store the new default value
            // initialize new view controller and cast it as your view controller
            let nextController = segue.destinationViewController as! PhotoInspectViewController
            nextController.passedValue = valueToPass
        }
    }
}
