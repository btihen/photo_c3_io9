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
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var urlString:   String?
    var searchTerm:  String?
    var valueToPass: String!
    var imageToPass: UIImage!
    var valuePassed: String?
    
    // FLICKR FEED (html) CODE
    var feed: Feed? {
        didSet {
            print( "FEED - update Tables" )
            self.tableView.reloadData()
        }
    }
    // keeps track of download sessions (of image downloads)
    var urlSession: NSURLSession!
    //
    weak var dataTask: NSURLSessionDataTask?
    // create the nsurl session as downloads start
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.urlSession = NSURLSession(configuration: configuration)
    }
    // destroy nsurl session when view goes away --
    // don't keep downloading images when not needed!
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.urlSession.invalidateAndCancel()
        self.urlSession = nil
    }
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print( "FLICKR PHOTO CONTROLLER" )
        if valuePassed == nil {
            // use last search info
            print( "USING STORED VALUES" )
            searchTerm = defaults.stringForKey("SearchTerm")!
        } else {
            // use passed data
            print( "USING PASSED VALUES" )
            searchTerm = valuePassed!
        }
        urlString  = "https://api.flickr.com/services/feeds/photos_public.gne?" + searchTerm! + "&format=json&nojsoncallback=1"
        print( "FLICKR SEARCH TERM " + searchTerm! )
        print( "FLICKR SEARCH URL "  + urlString! )
        tableView.delegate     = self
        tableView.dataSource   = self
        
        getURL( urlString! )
    }

    func getURL( urlString: String ) {
        print( "GET URL FUNC" )
        print( "using URL: " + urlString )
        
        if let url = NSURL(string: urlString) {
            self.updateFeed(url, completion: { (feed) -> Void in
                //let viewController = application.windows[0].rootViewController as? PhotoViewController
                //viewController.feed = feed
                self.feed = feed
            })
        }
    }
    func updateFeed(url: NSURL, completion: (feed: Feed?) -> Void) {
        print( "UPDATE FEED" )
        let request = NSURLRequest(URL: url)
        print( " GET URL REQUEST " )
        print( request )
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error == nil && data != nil {
                let feed = Feed(data: data!, sourceURL: url)
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completion(feed: feed)
                })
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return images.count
        print( "COUNT = " )
        print( self.feed?.items.count ?? 0 )
        return self.feed?.items.count ?? 0
    }
    
    // keeps track of which cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath )
        // using static images
        //cell.textLabel?.text = "Photo of " + images[indexPath.row]
        //cell.imageView?.image = UIImage( named: images[indexPath.row] )
        // flickr feed
        let item = self.feed!.items[indexPath.row]
        // assign text
        cell.textLabel?.text = item.title
        // while using text will just send this image (image is ALWAYS NEED FOR SEGUES!)
        cell.imageView?.image = UIImage( named: "sample" )
        
        // add flickr images soon
        
        return cell
    }
    
    // next two methods involving passing methods ideas (with some modifications)
    // http://stackoverflow.com/questions/8130600/use-didselectrowatindexpath-or-prepareforsegue-method-for-uitableview
    // and some ideas from 
    // http://stackoverflow.com/questions/28430663/send-data-from-tableview-to-detailview-swift
    
    // delegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // valueToPass = images[indexPath.row]
        //// NSUserDefaults.standardUserDefaults().setObject(selectedImage, forKey: "DefaultImage")
        //// valueToPass = selectedImage
        // imageToPass = UIImage( named: images[indexPath.row] )
        
        // NEW CODE Flickr Feed
        let cellData = self.feed!.items[indexPath.row]
        valueToPass = cellData.title
        // need to change for flicker - but good testing
        //imageToPass = cellData.imageView?.image
        
        print( "SELECTED IMAGE ROW" + valueToPass + " TITLE" )
        imageToPass = UIImage( named: "sample" )
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        print( "Segue OVERRIDE" )
        if (segue.identifier == "InspectImage") {
            print( "Inspect Image Segue" )
            let selectedRow = self.tableView.indexPathForSelectedRow?.row
            
            // OLD STATIC IMAGES CODE
            //valueToPass = images[selectedRow!]
            //imageToPass = UIImage( named: images[selectedRow!] )
            
            // NEW CODE Flickr Feed
            let item = self.feed!.items[selectedRow!]
            valueToPass = item.title
            let imageURL = self.feed!.items[selectedRow!].imageURL
            print( "IMAGE URL " )
            print( imageURL )
            // need to change for flicker - but good testing
            imageToPass = UIImage( named: "sample" )
            
            print( "SEGUE PASSING VALUE -- " + valueToPass + "Title" )
            // initialize new view controller and cast it as your view controller
            let nextController = segue.destinationViewController as! PhotoInspectViewController
            nextController.passedImage = imageToPass
        }
    }
}
