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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as UIViewController
        self.presentViewController(viewController, animated: true, completion: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func bind() {
        println("Bind")
    }
    
    override func viewDidAppear(animated: Bool) {
        println("viewDidAppear")
    }
}
