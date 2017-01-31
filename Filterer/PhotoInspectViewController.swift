//
//  PhotoInspectViewController.swift
//  Filterer
//
//  Created by Bill Tihen on 31.01.17.
//  Copyright © 2017 UofT. All rights reserved.
//

import UIKit

class PhotoInspectViewController: UIViewController {

    var passedValue: String?
    var originalImage = UIImage( named: "landscape" )!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print( "PHOTO INSPECTOR CONTROLLER" )
        if passedValue != nil {
            print( "PASSED VALUE " + passedValue! )
        } else {
            print( "PASSED VALUE = NIL" )
        }
        passedValue = "sample"
        // passedValue = "landscape"
        originalImage = UIImage( named: passedValue! )!
        imageView.image = originalImage
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
