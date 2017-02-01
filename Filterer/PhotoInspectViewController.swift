//
//  PhotoInspectViewController.swift
//  Filterer
//
//  Created by Bill Tihen on 31.01.17.
//  Copyright © 2017 UofT. All rights reserved.
//

import UIKit

class PhotoInspectViewController: UIViewController {

    // var passedValue: String?
    var passedImage: UIImage?
    var inspectImage: UIImage?

    var defaultImage = UIImage( named: "landscape" )!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print( "PHOTO INSPECTOR CONTROLLER" )
        if passedImage == nil {
            print( "PASSED Image = NIL" )
            print( "using Defaults" )
            // passedValue  = "landscape"
            inspectImage = defaultImage
        } else {
            // print( "PASSED IMAGE " + passedValue! )
            print( "PASSED IMAGE" )
            inspectImage = passedImage
        }
        // passedValue = "sample"
        // passedValue = "landscape"
        // inspectImage = UIImage( named: passedValue! )!
        imageView.image = inspectImage
    }

    @IBAction func onSave(sender: UIBarButtonItem) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(PhotoInspectViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Your flickr image has been saved to your photos.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }

}
