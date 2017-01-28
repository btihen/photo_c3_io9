//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var sliderValue: Int?

    var filteredImage: UIImage?
    var originalImage: UIImage?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imagePressGesture: UILongPressGestureRecognizer!
    
    @IBOutlet var topLabel: UIView!
    @IBOutlet var sliderMenu: UIView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet var filterButton: UIButton!
    @IBOutlet weak var lightenButton: UIButton!
    @IBOutlet weak var darkenButton: UIButton!
    @IBOutlet weak var contrastButton: UIButton!
    @IBOutlet weak var greyButton: UIButton!
    @IBOutlet weak var bwButton: UIButton!
    
    @IBOutlet weak var compareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        sliderMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        sliderMenu.translatesAutoresizingMaskIntoConstraints = false
        topLabel.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        topLabel.translatesAutoresizingMaskIntoConstraints=false
        
        filterButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Selected);
        compareButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Selected);
        
        lightenButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Selected);
        darkenButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Selected);
        contrastButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Selected);
        greyButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Selected);
        bwButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Selected);
        
        // on app load - create an original image
        originalImage = UIImage( named: "scenery" )!
        // load original image into display
        imageView.image = originalImage
        // on app load - disable compare button since there is no filtered image yet
        compareButton.enabled = false
    }
    
    
    // http://stackoverflow.com/questions/7638831/fade-dissolve-when-changing-uiimageviews-image
    @IBAction func endCompare(sender: UIButton) {
        hideTopLabel()
        let toImage = filteredImage
        UIView.transitionWithView(self.imageView,
                                  duration:0.5,
                                  options: UIViewAnimationOptions.TransitionCrossDissolve,
                                  animations: { self.imageView.image = toImage },
                                  completion: nil)
        imageView.image = filteredImage
        compareButton.selected = false
    }
    @IBAction func onCompare(sender: UIButton) {
        showTopLabel()
        let toImage = originalImage
        UIView.transitionWithView(self.imageView,
                                  duration:0.5,
                                  options: UIViewAnimationOptions.TransitionCrossDissolve,
                                  animations: { self.imageView.image = toImage },
                                  completion: nil)
        imageView.image = originalImage
        compareButton.selected = true
    }
    // @IBAction func compareToggle(sender: UIButton) {
        //        if compareButton.selected {
        //            let toImage = filteredImage
        //            UIView.transitionWithView(self.imageView,
        //                                      duration:1,
        //                                      options: UIViewAnimationOptions.TransitionCrossDissolve,
        //                                      animations: { self.imageView.image = toImage },
        //                                      completion: nil)
        //            imageView.image = filteredImage
        //            compareButton.selected = false
        //        } else {
        //            let toImage = originalImage
        //            UIView.transitionWithView(self.imageView,
        //                                      duration:1,
        //                                      options: UIViewAnimationOptions.TransitionCrossDissolve,
        //                                      animations: { self.imageView.image = toImage },
        //                                      completion: nil)
        //            imageView.image = originalImage
        //            compareButton.selected = true
        //        }
    // }
    
    // trick is to make sure the image view can see gestures!
    @IBAction func onImagePress(sender: AnyObject) {
        // print("Long tap")
        if compareButton.enabled == true {
            if sender.state == .Ended {
                //print("touches ended view")
                if filteredImage == nil {
                    imageView.image = originalImage
                } else {
                    hideTopLabel()
                    let toImage = filteredImage
                    UIView.transitionWithView(self.imageView,
                                              duration:0.5,
                                              options: UIViewAnimationOptions.TransitionCrossDissolve,
                                              animations: { self.imageView.image = toImage },
                                              completion: nil)
                    imageView.image = filteredImage
                }
            }
            else if sender.state == .Began {
                // print("touches began view")
                showTopLabel()
                let toImage = originalImage
                UIView.transitionWithView(self.imageView,
                                          duration:0.5,
                                          options: UIViewAnimationOptions.TransitionCrossDissolve,
                                          animations: { self.imageView.image = toImage },
                                          completion: nil)

                imageView.image = originalImage
            }
        }
    }
    // doing touches by hand - just experimenting
    //    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    //        super.touchesBegan(touches, withEvent: event)
    //        print("touches began view")
    //        imageView.image = originalImage
    //    }
    //
    //    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    //        super.touchesEnded(touches, withEvent: event)
    //        print("touches ended view")
    //        if filteredImage == nil {
    //            imageView.image = originalImage
    //        } else {
    //            imageView.image = filteredImage
    //        }
    //    }
    
    
    func showTopLabel(){
        view.addSubview(topLabel)
        let heightConstraint = topLabel.heightAnchor.constraintEqualToConstant(55)
        let leftConstraint   = topLabel.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint  = topLabel.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let topConstraint = topLabel.topAnchor.constraintEqualToAnchor(view.topAnchor)
        //let bottomConstraint = topLabel.bottomAnchor.constraintEqualToAnchor(imageView.topAnchor)
        NSLayoutConstraint.activateConstraints([topConstraint,leftConstraint,rightConstraint,heightConstraint])
        //NSLayoutConstraint.activateConstraints([bottomConstraint,leftConstraint,rightConstraint,heightConstraint])
        view.layoutIfNeeded()
        topLabel.alpha=0
        UIView.animateWithDuration(0.2){
            self.topLabel.alpha=1.0
        }
    }
    
    func hideTopLabel(){
        UIView.animateWithDuration(0.4,animations: {self.topLabel.alpha=0}){ completed in
            if (completed==true){self.topLabel.removeFromSuperview()}
        }
    }

    
    @IBAction func onSlider(sender: UISlider) {
        // print("on slider")
        // print( sliderValue )
        sliderValue = Int(sender.value)
        // sliderValue = roundUp(Int(sender.value), divisor: 1000)
        if lightenButton.selected == true {
            filteredImage = LightenFilter(percentage: sliderValue!).filter( originalImage! )
        }
        if darkenButton.selected == true {
            filteredImage = DarkenFilter(percentage: sliderValue!).filter( originalImage! )
        }
        if contrastButton.selected == true {
            //print( sliderValue )
            filteredImage = ContrastFilter(percentage: sliderValue!).filter( originalImage! )
        }
        if greyButton.selected == true {
            filteredImage = GreyFilter(percentage: sliderValue!).filter( originalImage! )
        }
        if bwButton.selected == true {
            filteredImage = BnWFilter(percentage: sliderValue!).filter( originalImage! )
        }
        imageView.image = filteredImage
    }
   
    @IBAction func onLightenFilter(sender: UIButton) {
        if lightenButton.selected {
            lightenButton.selected = false
            imageView.image = originalImage
            compareButton.enabled = false
            filteredImage = nil
            hideSliderMenu()
        } else {
            lightenButton.selected  = true
            darkenButton.selected   = false
            contrastButton.selected = false
            greyButton.selected     = false
            bwButton.selected       = false
            compareButton.enabled   = true
            filteredImage = LightenFilter(percentage: 75).filter( originalImage! )
            showSliderMenu()
            imageView.image = filteredImage
        }
    }

    @IBAction func onDarkenFilter(sender: UIButton) {
        if darkenButton.selected {
            darkenButton.selected = false
            imageView.image = originalImage
            compareButton.enabled = false
            filteredImage = nil
            hideSliderMenu()
        } else {
            lightenButton.selected  = false
            darkenButton.selected   = true
            contrastButton.selected = false
            greyButton.selected     = false
            bwButton.selected       = false
            compareButton.enabled   = true
            filteredImage = DarkenFilter(percentage: 75).filter( originalImage! )
            showSliderMenu()
            imageView.image = filteredImage
        }
    }
    
    @IBAction func onContrastFilter(sender: UIButton) {
        if contrastButton.selected {
            contrastButton.selected = false
            imageView.image = originalImage
            compareButton.enabled = false
            filteredImage = nil
            hideSliderMenu()
        } else {
            lightenButton.selected  = false
            darkenButton.selected   = false
            contrastButton.selected = true
            greyButton.selected     = false
            bwButton.selected       = false
            compareButton.enabled   = true
            filteredImage = ContrastFilter(percentage: 75).filter( originalImage! )
            showSliderMenu()
            imageView.image = filteredImage
        }
    }
    
    @IBAction func onGreyFilter(sender: UIButton) {
        if greyButton.selected {
            greyButton.selected = false
            imageView.image = originalImage
            compareButton.enabled = false
            filteredImage = nil
            hideSliderMenu()
        } else {
            lightenButton.selected  = false
            darkenButton.selected   = false
            contrastButton.selected = false
            greyButton.selected     = true
            bwButton.selected       = false
            compareButton.enabled   = true
            filteredImage = GreyFilter(percentage: 75).filter( originalImage! )
            showSliderMenu()
            imageView.image = filteredImage
        }
    }
    
    @IBAction func onBWFilter(sender: UIButton) {
        if bwButton.selected {
            bwButton.selected = false
            imageView.image = originalImage
            compareButton.enabled = false
            filteredImage = nil
            hideSliderMenu()
        } else {
            lightenButton.selected  = false
            darkenButton.selected   = false
            contrastButton.selected = false
            greyButton.selected     = false
            bwButton.selected       = true
            compareButton.enabled   = true
            filteredImage = BnWFilter(percentage: 75).filter( originalImage! )
            showSliderMenu()
            imageView.image = filteredImage
        }
    }
    
    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let newImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            filteredImage = nil
            originalImage = newImage
            imageView.image = newImage
            compareButton.enabled = false
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }

    func showSliderMenu() {
        view.addSubview(sliderMenu)
        
        let bottomConstraint = sliderMenu.bottomAnchor.constraintEqualToAnchor(secondaryMenu.topAnchor)
        let leftConstraint = sliderMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = sliderMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = sliderMenu.heightAnchor.constraintEqualToConstant(45)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.sliderMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.sliderMenu.alpha = 1.0
        }
    }
    
    func hideSliderMenu() {
        UIView.animateWithDuration(0.3, animations: {
            self.sliderMenu.alpha = 0
        }) { completed in
            if completed == true {
                self.sliderMenu.removeFromSuperview()
            }
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(45)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
        if compareButton.enabled == true {
            showSliderMenu()
        }
    }

    func hideSecondaryMenu() {
        hideSliderMenu()
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }

}
