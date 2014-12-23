//
//  ViewController.swift
//  Embriago
//
//  Created by Jon Kurisu on 12/22/14.
//  Copyright (c) 2014 AOTO Systems, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerUserButton: UIButton!
    
    @IBOutlet weak var messagesLabel: UILabel!
    
    let viewModel: BaseViewModel
    
    required init(coder: NSCoder) {
        viewModel = RegisterUserViewModel()
        super.init(coder: coder)
//        fatalError("NSCoding not supported")
    }
    
    init(viewModel: BaseViewModel) {
        self.viewModel = viewModel
        // I need to verify that nil is appropriate for nibName and bundle
        super.init(nibName: nil, bundle: nil)
    }
    
    @IBAction func segueToLogin(sender: AnyObject) {
        performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("ViewController: \(segue.identifier)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(PFUser.currentUser())
//        var testObject = PFObject(className: "TestObject")
//        testObject["Name"] = "TestObject Name"
//        testObject["Version"] = 1.1
//        testObject.saveInBackgroundWithBlock({
//            (succeeded, error) -> Void in
//            if(succeeded) {
//                println("TestObject saved")
//            } else {
//                println(error)
//            }
//        })
//        var loginView = FBLoginView()
//        loginView.center = self.view.center
//        self.view.addSubview(loginView)
        
        bind()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            performSegueWithIdentifier("goHome", sender: self)
//            let homeViewController = HomeViewController(nibName: nil, bundle: nil)
//            self.navigationController?.pushViewController(homeViewController, animated: animated)
        }
    }
    
        func bind() {
            let emailAddressTextSignal = emailAddressTextField.rac_textSignal().map {
                (text: AnyObject!) -> NSNumber in
                let textString = text as NSString
                return textString.length
                }.filter {
                    (length: AnyObject!) -> Bool in
                    let value = length as NSNumber
                    return value.integerValue >= 3
                }.subscribeNext { (valid: AnyObject!) -> Void in
                    let validValue = valid as Bool
                    println("Email Address: \(validValue) \(self.emailAddressTextField.text)")
                }
            
            let validEmailAddressSignal = emailAddressTextField.rac_textSignal().map {
                (text: AnyObject!) -> NSNumber in
                let textString = text as String
                return self.isValidEmailAddress(textString)
            }
            
//            RAC(self.emailAddressTextField, "backgroundColor") << validEmailAddressSignal.map {
//                                    (valid: AnyObject!) -> UIColor in
//                                    let validValue = valid as Bool
//                                    return validValue ? UIColor.clearColor() : UIColor.yellowColor()
//                             }
            
//            RAC(self.emailAddressTextField, "backgroundColor") <<
//                validEmailAddressSignal.map {
//                    (valid: AnyObject!) -> UIColor in
//                    let validValue = valid as Bool
//                    return validValue ? UIColor.clearColor() : UIColor.yellowColor()
//             }
            
            let nameTextSignal = nameTextField.rac_textSignal().map {
                (text: AnyObject!) -> NSNumber in
                let textString = text as NSString
                return textString.length
                }.filter {
                    (length: AnyObject!) -> Bool in
                    let value = length as NSNumber
                    return value.integerValue >= 1
                }.subscribeNext { (valid: AnyObject!) -> Void in
                    let validValue = valid as Bool
                    println("Name: \(validValue) \(self.nameTextField.text)")
                }
    
            let passwordTextSignal = passwordTextField.rac_textSignal().map {
                (text: AnyObject!) -> NSNumber in
                let textString = text as NSString
                return textString.length
                }.subscribeNext {
                    (length: AnyObject!) -> Void in
                    let value = length as NSNumber
                    self.registerUserButton.enabled = value.integerValue >= 8
                }
//            let passwordTextSignal = passwordTextField.rac_textSignal().map {
//                (text: AnyObject!) -> NSNumber in
//                let textString = text as NSString
//                return textString.length
//                }.filter {
//                    (length: AnyObject!) -> Bool in
//                    let value = length as NSNumber
//                    return value.integerValue >= 8
//                }.subscribeNext { (valid: AnyObject!) -> Void in
//                    let validValue = valid as Bool
//                    self.registerUserButton.enabled = validValue
//                    println("Password: \(validValue) \(self.nameTextField.text)")
//            }
            
            let registerUserSignal = registerUserButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside)
            registerUserSignal.subscribeNext {
                (value:AnyObject!) -> Void in
                self.register(self.emailAddressTextField.text, name: self.nameTextField.text, password: self.passwordTextField.text)
            }
    
    //        let passwordTextSignal = passwordTextField.rac_textSignal().map {
    //            (text: AnyObject!) -> NSNumber in
    //            let textString = text as NSString
    //            return textString.length
    //            }.filter {
    //                (length: AnyObject!) -> Bool in
    //                let value = length as NSNumber
    //                return value.integerValue >= 8
    //            }.setKeyPath("enabled", onObject: registerUserButton)
    
        }

    
//    private func bind() {
//        let validEmailAddressSignal = emailAddressTextField.rac_textSignal().map {
//            (text: AnyObject!) -> NSNumber in
//            let textString = text as String
//            return self.isValidEmailAddress(textString)
//        }
//        
//        RAC(registerUserButton, "enabled") = validEmailAddressSignal.map {
//            
//        }
//
//    }
    
    private func register(emailAddress: String, name: String, password: String) {
        var user = PFUser()
        user.username = emailAddress
        user.password = password
        user.email = emailAddress
        user.setObject(name, forKey: "displayName")
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                self.performSegueWithIdentifier("goHome", sender: self)
            } else {
                var alertView = SCLAlertView();
                alertView.alertIsDismissed({ () -> Void in
                    self.emailAddressTextField.text = ""
                    self.nameTextField.text = ""
                    self.passwordTextField.text = ""
                })
                if let errorString = error.userInfo?["error"] as? NSString {
                    alertView.showError(self, title: "Error registering", subTitle: errorString, closeButtonTitle: "Close", duration: 0.0)
                } else {
                    alertView.showError(self, title: "Error", subTitle: "There was an error registering in the user", closeButtonTitle: "Close", duration: 0.0)
                }
            }
        }
    }
    
    func isValidPassword(password: String) -> Bool {
        return false
    }
    
    func isValidName(name: String) -> Bool {
        return false
    }
    
    func isValidEmailAddress(emailAddress: NSString) -> Bool {
        println(emailAddress)
        if(emailAddress.length > 2) {
            return true
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

