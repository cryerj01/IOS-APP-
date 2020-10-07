//
//  LoginViewController.swift
//  ios
//
//  Created by Joseph Cryer on 12/03/2020.
//  Copyright © 2020 Joseph Cryer. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        userCheck()

        // Do any additional setup after loading the view.
        
        setupElements()
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
    
    func setupElements(){
        //hide the error lable
        error.alpha = 0
    }
    
    func validateFields() -> String?{
        if(pass.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""
            || email.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ){
            return "please fill in all fields"
        }
        return nil
    }
    
    func showError(message:String){
        error.text = message
        error.alpha = 1
    }
    

    @IBAction func onClick(_ sender: Any) {
        //validat text fields
        
        let error = validateFields()
        
        if error != nil{
            //there is an error. show error
            showError(message: error!)
            
        }else{
        
        
        //log user in
            let cleanedEmail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = pass.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            signIn(email: cleanedEmail, password: password)
            
        }
    }
    
    func signIn(email: String, password: String){
    
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                self.error.text = error?.localizedDescription
                self.error.alpha = 1
                
            }else{
                self.transitionToHome()
            }
        }
    }
}
