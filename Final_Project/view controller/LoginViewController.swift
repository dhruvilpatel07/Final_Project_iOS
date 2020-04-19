//
//  LoginViewController.swift
//  CapstonePrototypeCustomer
//
//  Created by Dhruvil Patel on 2020-04-09.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        // hide the lable
        lblError.alpha = 0
        // Style the elements
        Utilities.styleTextField(txtEmail)
        Utilities.styleTextField(txtPassword)
        Utilities.styleFilledButton(btnLogin)
    }
    
    func showError(_ message:String){
        lblError.text = message
        lblError.alpha = 1
    }
    
    func transitionToHome(){
        
        let mainTabController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.mainTabControllerVC) as! MainTabControllerViewController
        
        present(mainTabController, animated: true, completion: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        //Creating clead data/ trimming any white spaces
        let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Setting up sign in method from firebase
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                //couldn't sign in
                //self.showError("Error Login in ")
                self.lblError.text = error!.localizedDescription
                self.lblError.alpha = 1
                //var uid = result!.user.uid
            }
            else{
                guard let userID = Auth.auth().currentUser?.uid else { return }
                print(userID)
                self.mainDelegate.userId = userID
                
                self.transitionToHome()
                self.txtEmail.text = ""
                self.txtPassword.text = ""
            }//End of If 
        }//End of Auth.auth.signIn()
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
