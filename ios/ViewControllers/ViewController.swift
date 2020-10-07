//
//  ViewController.swift
//  ios
//
//  Created by Joseph Cryer on 06/02/2020.
//  Copyright © 2020 Joseph Cryer. All rights reserved.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var SingUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userCheck()
        
        
        // Do any additional setup after loading the view.
        
    }
   
    
    func userCheck(){
        if Auth.auth().currentUser != nil {
            transitionToHome()
        }
    }
    func transitionToHome(){
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    
    
    
    
 
    
}

