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
    
    var getPhotoAndCaption: PFObject! {
        
        didSet {
            captionLabel.text = getPhotoAndCaption["caption"] as? String
            
            if let postedImageView = getPhotoAndCaption["media"] as? PFFile {
                postedImageView.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        self.postedImageView.image = UIImage(data:imageData!)
                    }
                })
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
