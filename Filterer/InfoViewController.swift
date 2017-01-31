//
//  InfoViewController.swift
//  Filterer
//
//  Created by Bill Tihen on 31.01.17.
//  Copyright © 2017 UofT. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    
    // sane long string formatting
    // http://stackoverflow.com/questions/24091233/swift-split-string-over-multiple-lines
    let infoText = "APP INFO:" +
        "\n\n" +
        "* Double Tap -- Zooms" +
        "\n\n" +
        "* Tap & Drag -- allows panning" +
        "\n\n" +
        "* Pinch Gestures -- allows zooming and an overview" +
        "\n\n" +
        "* Long Touch -- switches between original and filtered image" +
        "\n\n" +
        "* CREDIT: URLs of contributed ideas are in the code"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // multi-line label
        // http://stackoverflow.com/questions/30151237/adding-multiple-lines-of-text-into-uilabel-in-swift
        // remove line number restrictions (also possible to set in the storyboar)
        // http://stackoverflow.com/questions/2312899/how-to-add-line-break-for-uilabel
        infoLabel.numberOfLines = 0
        infoLabel.text = infoText
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
