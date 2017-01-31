//
//  PhotosViewController.swift
//  Filterer
//
//  Created by Bill Tihen on 29.01.17.
//  Copyright © 2017 UofT. All rights reserved.
//

import UIKit

class OldPhotosViewController: UITableViewController {
    
    var searchURL:  String?
    var searchTerm: String?
    var urlSession: NSURLSession!
    
    let images = [
        "sample",
        "scenery",
        "landscape"
    ]
    
    var feed: Feed? {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.urlSession = NSURLSession(configuration: configuration)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.urlSession.invalidateAndCancel()
        self.urlSession = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchURL  = NSUserDefaults.standardUserDefaults().stringForKey("SearchURL")
        searchTerm = NSUserDefaults.standardUserDefaults().stringForKey("SearchTerm")
        
        // set the title of the page to the search term
        // http://stackoverflow.com/questions/25167458/changing-navigation-title-programmatically
        self.title = "Flickr: " + searchTerm!
        
        print( "Photo Controller")
        print( searchTerm! )
        print( searchURL! )
        
        // print( "Search Term: " + searchTerm! )

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        let photoURL = "sample"
        NSUserDefaults.standardUserDefaults().setObject(photoURL,  forKey: "PhotoLoad")
        return true
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // return 1
        // URL results count
        print( self.feed?.items.count ?? 0 )
        return self.feed?.items.count ?? 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "Photo of " + searchTerm!
        cell.imageView?.image = UIImage(named: "sample")
        /*
        let item = self.feed!.items[indexPath.row]
        cell.textLabel?.text = item.title
        let request = NSURLRequest(URL: item.imageURL)
        print( request )

        cell.imageView? = self.urlSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
             NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                 if error == nil && data != nil {
                 let image = UIImage(data: data!)
                 cell.imageView?.image = image
                 // cell.itemImageView.image = image
                 }
             })
        cell.imageView?.resume()
        */
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
