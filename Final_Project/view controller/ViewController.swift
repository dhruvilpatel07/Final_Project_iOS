//
//  ViewController.swift
//  Final_Project
//
//  Created by Dhruvil Patel on 2020-04-18.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        
    }
    func setUpElements(){
        
        Utilities.styleHollowButton(btnLogin)
        Utilities.styleHollowButton(btnSignUp)
        
        
    }


}

