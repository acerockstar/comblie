//
//  EnlargedItemViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class EnlargedItemViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var enlargedImage: UIImageView!
    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeSymbol: UIButton!
    @IBOutlet weak var commentSymbol: UIButton!
    @IBOutlet weak var numLikesLabel: UILabel!
    @IBOutlet weak var numCommentsLabel: UILabel!
    
    @IBAction func likeButtonClicked(sender: UIButton) {
        // Increment/decrement likes count
        println("liked button clicked")
    }
    
    @IBAction func commentButtonClicked(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
        let newVC = storyboard.instantiateViewControllerWithIdentifier("commentsVC") as! CommentsViewController
        self.presentViewController(newVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        likeSymbol.tintColor = UIColor.whiteColor()
        commentSymbol.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
