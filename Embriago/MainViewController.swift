//
//  MainViewController.swift
//  Embriago
//
//  Created by Jon Kurisu on 12/24/14.
//  Copyright (c) 2014 AOTO Systems, Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        displayLoginViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() == nil {
            displayLoginViewController()
        }
    }
    
    private func displayLoginViewController() {
        let loginViewController = EmbriagoLoginViewController()
        loginViewController.delegate = self
        
        let signupViewController = EmbriagoSignUpViewController()
        loginViewController.signUpController = signupViewController
        
        presentViewController(loginViewController, animated: true, completion: { () -> Void in
            println("completion")
        })
    }
    
    
    func logInViewController(logInController: PFLogInViewController!, didFailToLogInWithError error: NSError!) {
        println("didFailToLogInWithError \(error)")
    }
    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        println("didLogInUser")
        presentViewController(self, animated: true, completion: { () -> Void in
            println("completion")
        })
    }
    
//    func logInViewController(logInController: PFLogInViewController!, shouldBeginLogInWithUsername username: String!, password: String!) -> Bool {
//        println("shouldBeginLogInWithUsername")
//        let usernameString = NSString(string: username)
//        let passwordString = NSString(string: password)
//        if username != nil && password != nil && usernameString.length != 0 && passwordString != 0 {
//            return true
//        } else {
//            println("Missing information")
//            return false
//        }
//    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController!) {
        println("logInViewControllerDidCancelLogIn")
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, didFailToSignUpWithError error: NSError!) {
        println("didFailToSignUpWithError \(error)")
        
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
        println("didSignUpUser")
    }
    
//    func signUpViewController(signUpController: PFSignUpViewController!, shouldBeginSignUp info: [NSObject : AnyObject]!) -> Bool {
//        println("shouldBeginSignUp")
//        var result = true
//        for item in info.keys {
//            if let value = item as? NSString {
//                if value.length == 0 {
//                    println("Missing information")
//                    result = false
//                    break
//                }
//            } else {
//                println("Missing information")
//                result = false
//                break
//            }
//        }
//        return true
//    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController!) {
        println("signUpViewControllerDidCancelSignUp")
    }
}
