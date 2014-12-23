//
//  LoginViewController.swift
//  Embriago
//
//  Created by Jon Kurisu on 12/22/14.
//  Copyright (c) 2014 AOTO Systems, Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginUserButton: UIButton!
    
    
    @IBAction func segueToRegister(sender: AnyObject) {
        performSegueWithIdentifier("registerSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("LoginViewController: \(segue.identifier)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
    }
    
    private func login(emailAddress: String, password: String) {
        PFUser.logInWithUsernameInBackground(emailAddress, password: password) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("goHome", sender: self)
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


}
