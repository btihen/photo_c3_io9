//
//  SearchView.swift
//  Filterer
//
//  Created by Bill Tihen on 28.01.17.
//  Copyright © 2017 UofT. All rights reserved.
//

import UIKit

class SearchView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    let urlString = NSUserDefaults.standardUserDefaults().stringForKey("PhotoFeedURLString")
    // print(urlString)
    searchButton.setTitle("Find /(urlString)", forState: .Normal)
}
