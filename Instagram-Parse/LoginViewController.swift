//
//  LoginViewController.swift
//  Instagram-Parse
//
//  Created by Tasfia Addrita on 3/4/16.
//  Copyright © 2016 Tasfia Addrita. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var gradient : CAGradientLayer?
    var fromColors : AnyObject?
    var toColors : AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoImageView.image = UIImage(named: "momentsLogo.png")
        
        //usernameTextField.backgroundColor = UIColor.clearColor()
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()])
        usernameTextField.textColor = UIColor.whiteColor()
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()])
        passwordTextField.textColor = UIColor.whiteColor()
        
//        var frameRect: CGRect = usernameTextField.frame
//        frameRect.size.height = 100
//        usernameTextField.frame = frameRect
        
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
        //animation.duration = 3.00
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!)
            { (user: PFUser?, error: NSError?) -> Void in
                
                if user != nil {
                    print("You're logged in")
                    self.performSegueWithIdentifier("loginSegue", sender: nil)
                }
            
            }
    }

    /*@IBAction func onSignUp(sender: AnyObject) {
        
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if success {
                print("Yay, created a user")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print("error: \(error?.localizedDescription)")
            }
            
        }
        
    }*/
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
