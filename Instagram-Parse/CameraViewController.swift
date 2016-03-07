//
//  CameraViewController.swift
//  Instagram-Parse
//
//  Created by Tasfia Addrita on 3/5/16.
//  Copyright © 2016 Tasfia Addrita. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadPhotoImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    let pickImage = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadPhotoImageView.image = UIImage(named: "uploadphoto.png")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onUploadPhoto(sender: AnyObject) {
        pickImage.delegate = self
        pickImage.allowsEditing = true
        pickImage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(pickImage, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
        // Do something with the images (based on your use case)
        //uploadPhotoImageView.image = editedImage
        let size = CGSize(width: 320, height: 320)
        uploadPhotoImageView.image = resize(editedImage, newSize: size)
            
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPost(sender: AnyObject) {
        
        if (uploadPhotoImageView.image != nil || captionTextField.text != nil) {
            
            Post.postUserImage(uploadPhotoImageView.image, withCaption: captionTextField.text, withCompletion: nil)
            uploadPhotoImageView.image = UIImage(named: "uploadphoto.png")
            captionTextField.text = ""
        }
        
        let seconds = 3.5
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
            self.tabBarController!.selectedIndex = 0;
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        })
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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

class Post: NSObject {
    /**
     * Other methods
     */
     
     /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, /*profPic: PFFile?,*/ withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        //post["userProfPic"] = profPic
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
