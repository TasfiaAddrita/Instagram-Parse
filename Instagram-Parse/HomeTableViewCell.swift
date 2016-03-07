//
//  HomeTableViewCell.swift
//  Instagram-Parse
//
//  Created by Tasfia Addrita on 3/6/16.
//  Copyright © 2016 Tasfia Addrita. All rights reserved.
//

import UIKit
import Parse

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var postedImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var username2Label: UILabel!
    
    var getPhotoAndCaption: PFObject! {
        
        didSet {
            
            self.captionLabel.text = getPhotoAndCaption["caption"] as? String
            self.usernameLabel.text = PFUser.currentUser()?.username
            self.username2Label.text = PFUser.currentUser()?.username
            
            if let profileImageView = getPhotoAndCaption["userimage"] as? PFFile {
                profileImageView.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        self.postedImageView.image = UIImage(data:imageData!)
                    }
                }
            }
            
            if let postedImageView = getPhotoAndCaption["media"] as? PFFile {
                postedImageView.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        self.postedImageView.image = UIImage(data:imageData!)
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
