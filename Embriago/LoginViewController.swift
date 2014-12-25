//
//  LoginViewController.swift
//  Embriago
//
//  Created by Jon Kurisu on 12/22/14.
//  Copyright (c) 2014 AOTO Systems, Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBLoginViewDelegate {
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginUserButton: UIButton!
    
    @IBOutlet weak var loginView: FBLoginView!
    
    @IBOutlet weak var messagesLabel: UILabel!
    
    @IBAction func segueToRegister(sender: AnyObject) {
        performSegueWithIdentifier("registerSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("LoginViewController: \(segue.identifier)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        bind()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func bind() {
        
        
        let loginUserSignal = loginUserButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside)
        loginUserSignal.subscribeNext {
            (value: AnyObject!) -> Void in
            self.login(self.emailAddressTextField.text, password: self.passwordTextField.text)
//            self.login()
        }
    }
    
//    private func login() {
//        var permissions = ["public_profile"]
//        PFFacebookUtils.logInWithPermissions(permissions, block: {
//            (user: PFUser!, error: NSError!) -> Void in
//            if user == nil {
//                println("error")
//            } else {
//                println("OK")
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as UIViewController
//                self.presentViewController(homeViewController, animated: true, completion: nil)
//            }
//        })
//    }
    
    private func login(emailAddress: String, password: String) {
        PFUser.logInWithUsernameInBackground(emailAddress, password: password) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                println("Is linked: \(PFFacebookUtils.isLinkedWithUser(user))")
                if !PFFacebookUtils.isLinkedWithUser(user) {
                    PFFacebookUtils.linkUser(user, permissions: ["public_profile", "email", "user_friends"], {
                        (succeeded: Bool!, error: NSError!) -> Void in
                        println(succeeded)
                        if succeeded == true {
                            println("Link Successful")
                        } else {
                            println(error)
                        }
                    })
                }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as UIViewController
                self.presentViewController(homeViewController, animated: true, completion: nil)
            } else {
                var alertView = SCLAlertView();
                alertView.alertIsDismissed({ () -> Void in
                    self.emailAddressTextField.text = ""
                    self.passwordTextField.text = ""
                })
                if let errorString = error.userInfo?["error"] as? NSString {
                    alertView.showError(self, title: "Error", subTitle: errorString, closeButtonTitle: "Close", duration: 0.0)
                } else {
                    alertView.showError(self, title: "Error", subTitle: "There was an error logging in the user", closeButtonTitle: "Close", duration: 0.0)
                }
            }
        }
        

    }
    
    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        println(error)
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        println(user)
//        var facebookUser = PFUser()
//        facebookUser.setObject(user.name, forKey: "displayName")
//        if PFUser.currentUser() == nil {
//            var facebookUser = PFUser()
//            facebookUser.setObject(user.name, forKey: "displayName")
//            PFFacebookUtils.linkUser(facebookUser, facebookId: <#String!#>, accessToken: <#String!#>, expirationDate: <#NSDate!#>, block: <#PFBooleanResultBlock!##(Bool, NSError!) -> Void#>)
//        }
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as UIViewController
//        self.presentViewController(homeViewController, animated: true, completion: nil)
    }
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println("loginViewShowingLoggedInUser")
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        println("loginViewShowingLoggedOutUser")
    }
}
