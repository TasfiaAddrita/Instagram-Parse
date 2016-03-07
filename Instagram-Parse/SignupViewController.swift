//
//  SignupViewController.swift
//  Instagram-Parse
//
//  Created by Tasfia Addrita on 3/5/16.
//  Copyright © 2016 Tasfia Addrita. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userImageView: UIImageView!
    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var gradient : CAGradientLayer?
    var fromColors : AnyObject?
    var toColors : AnyObject?
    
    let pickImage = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        //userImageView.image = UIImage(named: "addProfileImage.png")
        
        /*nameTextField.attributedPlaceholder = NSAttributedString(string: "Full Name",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()])
        nameTextField.textColor = UIColor.whiteColor()*/
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()])
        usernameTextField.textColor = UIColor.whiteColor()
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()])
        passwordTextField.textColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.gradient = CAGradientLayer()
        self.gradient?.frame = self.view.bounds
        //self.gradient?.colors = [UIColor.redColor().CGColor, UIColor.redColor().CGColor]
        //self.gradient?.colors = [UIColor.redColor().CGColor, UIColor.yellowColor().CGColor]
        self.gradient?.colors = [
            UIColor(red: 237/255, green: 66/255, blue: 100/255, alpha: 1).CGColor,
            UIColor(red: 255/255, green: 237/255, blue: 188/255, alpha: 1).CGColor
        ]
        
        self.view.layer.insertSublayer(self.gradient!, atIndex: 0)
        
        //self.toColors = [UIColor.blueColor().CGColor, UIColor.blueColor().CGColor]
        //self.toColors = [UIColor.purpleColor().CGColor, UIColor.blueColor().CGColor]
        
        self.toColors = [
            UIColor(red: 123/255, green: 67/255, blue: 151/255, alpha: 1).CGColor,
            UIColor(red: 220/255, green: 36/255, blue: 48/255, alpha: 1).CGColor
        ]
        
        self.animateLayer()
        
    }
    
    func animateLayer() {
        
        self.fromColors = self.gradient?.colors
        self.gradient!.colors = self.toColors! as? [AnyObject]
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        animation.delegate = self
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 5.00
        animation.removedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        
        self.gradient?.addAnimation(animation, forKey:"animateGradient")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        self.toColors = self.fromColors;
        self.fromColors = (self.gradient?.colors)!
        animateLayer()
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if success {
                print("Yay, created a user")
                self.performSegueWithIdentifier("signupSegue", sender: nil)
            } else {
                print("error: \(error?.localizedDescription)")
            }
            
        }
    }
    
    /*@IBAction func onUploadProfileImage(sender: AnyObject) {
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
        userImageView.image = resize(editedImage, newSize: size)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
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
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }*/
    
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
