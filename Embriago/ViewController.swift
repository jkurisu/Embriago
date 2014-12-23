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
//        let emailAddressTextSignal = emailAddressTextField.rac_textSignal().map {
//            (text: AnyObject!) -> NSNumber in
//            let textString = text as NSString
//            return textString.length
//            }.filter {
//                (length: AnyObject!) -> Bool in
//                let value = length as NSNumber
//                return value.integerValue >= 3
//            }.setKeyPath("enabled", onObject: registerUserButton)
//        
//        let nameTextSignal = nameTextField.rac_textSignal().map {
//            (text: AnyObject!) -> NSNumber in
//            let textString = text as NSString
//            return textString.length
//            }.filter {
//                (length: AnyObject!) -> Bool in
//                let value = length as NSNumber
//                return value.integerValue >= 1
//            }.setKeyPath("enabled", onObject: registerUserButton)

        
        
//        nameTextSignal.subscribeNext { (text: AnyObject!) -> Void in
//            let textString = text as String
//            println("Name: \(textString)")
//        }
        
        
//        let emailAddressTextSignal = emailAddressTextField.rac_textSignal()
//        emailAddressTextSignal.subscribeNext { (text: AnyObject!) -> Void in
//            let textString = text as String
//            println("Email Address: \(textString)")
//        }
//        
//        let nameTextSignal = nameTextField.rac_textSignal()
//        nameTextSignal.subscribeNext { (text: AnyObject!) -> Void in
//            let textString = text as String
//            println("Name: \(textString)")
//        }

        
//        let passwordTextSignal = passwordTextField.rac_textSignal().map {
//            (text: AnyObject!) -> NSNumber in
//            let textString = text as NSString
//            return textString.length
//            }.filter {
//                (length: AnyObject!) -> Bool in
//                let value = length as NSNumber
//                return value.integerValue >= 8
//            }
        
        let passwordTextSignal = passwordTextField.rac_textSignal().map {
            (text: AnyObject!) -> NSNumber in
            let textString = text as NSString
            return textString.length
            }.filter {
                (length: AnyObject!) -> Bool in
                let value = length as NSNumber
                return value.integerValue >= 8
            }.subscribeNext { (valid: AnyObject!) -> Void in
                let validValue = valid as Bool
                self.registerUserButton.enabled = validValue
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
        
//        let loginButtonSignal = RACSignal.combineLatest([emailAddressTextSignal, nameTextSignal, passwordTextSignal]) {
//            (validEmailAddress: Bool, validName: Bool, validPassword: Bool) -> Bool in
//            return validEmailAddress && validName && validPassword
//        }
        
//        let passwordTextSignal = passwordTextField.rac_textSignal().map {
//            (text: AnyObject!) -> NSNumber in
//            let textString = text as NSString
//            return textString.length
//            }.filter {
//                (length: AnyObject!) -> Bool in
//                let value = length as NSNumber
//                return value.integerValue >= 8
//            }.subscribeNext { (valid: AnyObject!) -> Void in
//                let validValue = valid as Bool
//                println("Password: \(validValue) \(self.passwordTextField.text)")
//        }
        
//        let passwordLengthFilteredText = passwordTextSignal.filter( {(text: AnyObject!) -> Bool in
//            let textString = text as NSString
//            return textString.length >= 8
//        })
//        passwordLengthFilteredText.subscribeNext { (text: AnyObject!) -> Void in
//            let textString = text as String
//            println("Password: \(textString)")
//        }
        
//        emailAddressTextField.rac_textSignal() ~> RAC(viewModel, "emailAddressText")
    
    }
    
    func isValidPassword(password: String) -> Bool {
        return false
    }
    
    func isValidName(name: String) -> Bool {
        return false
    }
    
    func isValidEmailAddress(emailAddress: String) -> Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

