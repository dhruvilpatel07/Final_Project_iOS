//
//  SignUpViewController.swift
//  CapstonePrototypeCustomer
//
//  Created by Dhruvil Patel on 2020-04-09.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtVerifyPass: UITextField!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    @IBAction func registerTapped(_ sender: Any) {
        //Validate the field
        let error = validateField()
        
        if error != nil {
            showError(error!)
        }
        else{
            //Create cleaned version of data
            let name = txtName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let verifyPass = txtVerifyPass.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Checks if both password matches 
            if pass == verifyPass {
            //Create users
            Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
                
                //Check for error
                
                if err != nil {
                    //There is something wrong creating user
                    self.showError("Error Creating User")
                }
                else{
                    // User was stored successfully
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["email":email, "name":name, "uid":result!.user.uid], completion: { (error) in
                        if error != nil {
                            self.showError("Error saving user data ")
                        }
                    })
                    //Transition to home screen
                    self.transitionToHome()
                }//End of inner else for error
            }//end of Auth.auth()
            }//end of verify password check
        }//end of outter else for error
    }//End of registerTapped()
    
    func setUpElements(){
        // hide the lable
        lblError.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(txtEmail)
        Utilities.styleTextField(txtPassword)
        Utilities.styleTextField(txtName)
        Utilities.styleTextField(txtVerifyPass)
        Utilities.styleFilledButton(btnRegister)
        
        
    }
    
    func validateField() -> String? {
        
        //Check that all fileds are filled
        if txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtVerifyPass.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all field"
        }
        
       
        let cleanPassword = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanVefiryPassword = txtVerifyPass.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Checks if password matches the verify password
        if cleanPassword != cleanVefiryPassword {
            return "both password must be same"
        }
        else if Utilities.isPasswordValid(cleanPassword) == false { // //Check if password is secured
            // password isn't secured
            return "Please make sure password is at least 8 character, have special character and number "
            
        }
        
        
        
        return nil
    }
    
    func showError(_ message:String){
        lblError.text = message
        lblError.alpha = 1
    }
    
    func transitionToHome(){
        
        let mainTabController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.mainTabControllerVC) as! MainTabControllerViewController
        
        present(mainTabController, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
