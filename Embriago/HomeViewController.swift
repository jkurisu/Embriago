//
//  HomeViewController.swift
//  Embriago
//
//  Created by Jon Kurisu on 12/23/14.
//  Copyright (c) 2014 AOTO Systems, Inc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        performSegueWithIdentifier("gotoLogin", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func bind() {
        
    }
}
