//
//  ChatBubble.swift
//  
//
//  Created by Maxime Defauw on 16/09/15.
//
//

import UIKit

@IBDesignable class ChatBubble: UIView {
    
    var view: UIView!
    var networkType: NetworkType?
    var userName: String?
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBInspectable var image: UIImage? {
        get {
            return profileImage.image
        }
        set(image) {
            profileImage.image = image
        }
    }
    
    var nibName: String = "ChatBubble"
    
    // init
    
    override init(frame: CGRect) {
        // set properties
        super.init(frame: frame)
        
        // Set anything that uses the view or visible bounds
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        // set properties
        super.init(coder: aDecoder)
        
        // Set anything that uses the view or visible bounds
        setup()
    }
    func setup() {
        view = loadViewFromNib()
        
        view.frame = bounds
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
