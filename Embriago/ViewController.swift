//
//  ViewController.swift
//  Embriago
//
//  Created by Jon Kurisu on 12/22/14.
//  Copyright (c) 2014 AOTO Systems, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        var loginView = FBLoginView()
        loginView.center = self.view.center
        self.view.addSubview(loginView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

