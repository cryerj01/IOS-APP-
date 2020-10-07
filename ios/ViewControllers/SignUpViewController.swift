//
//  SignUpViewController.swift
//  ios
//
//  Created by Joseph Cryer on 12/03/2020.
//  Copyright © 2020 Joseph Cryer. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var Lname: UITextField!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var SignUpBtn: UIButton!
    @IBOutlet weak var Error: UILabel!
    @IBOutlet weak var pass1: UITextField!
    @IBOutlet weak var pass2: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupElements()
        userCheck()
    }
    
    func userCheck(){
        if Auth.auth().currentUser != nil {
            transitionToHome()
        }
    }
    func setupElements(){
        
        //hide the error lable
        Error.alpha = 0
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String?{
        
        if(fname.text?.trimmingCharacters(in:.whitespacesAndNewlines) == ""
            || Lname.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""
            || pass1.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""
            || pass2.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""
            || email.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ){
            
            return "please fill in all fields"
        }
        if(pass1.text!.trimmingCharacters(in: .whitespacesAndNewlines) == pass2.text!.trimmingCharacters(in: .whitespacesAndNewlines)){
            let cleanedPassword = pass1.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if( isPasswordValid( cleanedPassword) == false){
                return "please make sure you pass word is at least 8 characteras, contains a special caracture and a number"
            }
        }else{
            return "Passwords dont match"
        }
        
        
        
        return nil
    }
    
    func showError(message:String){
        Error.text = message
        Error.alpha = 1
    }
    
    
    @IBAction func onClick(_ sender: Any) {
        //validation
        let error = validateFields()
        
        if error != nil{
            //there is an error. show error
            showError(message: error!)
            
        }else{
            
            //make user
            //   let Fname = fname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //   let lname = Lname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Pass1 = pass1.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Pass2 = pass2.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if(Pass1 == Pass2){
                let FinalPass = Pass1
                Auth.auth().createUser(withEmail: Email, password: FinalPass)
                { (Result, err) in
                    if err != nil{
                        
                        self.showError(message: "Error creating User 1 " )
                    }
                    else{
                        //realtime data base code here.
                         self.transitionToHome()
                    }
                }
            }else{
                 self.showError(message: "Error creating User 2-- Pass1 not == Pass2")
            }
            
            
            
        }
    }
    
    
    func transitionToHome(){
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
}
//




