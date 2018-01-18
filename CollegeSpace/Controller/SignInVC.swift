//
//  LoginVC.swift
//  FinalConferenceApp
//
//  Created by Kanishk Verma on 04/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailLabel.delegate = self
        self.passwordLabel.delegate = self
        
        
    }
    
    //dismiss the keyboard when pressed outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    //dismiss the keyboard when pressed return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true);
        if let _ = KeychainWrapper.standard.string(forKey: Constants.KEY_UID) {
            print("JESS: ID found in keychain")
            doSegueMan()
        }
    }

    
    //=====================================Firebase AUTH Stuffs ===========================================
    func FirebaseAuth(_ credential:AuthCredential) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("++++++++++++++++Firebase Authentication Error++++++++++++")
            } else {
                print("Authentication completed with Firebase")
                
                let userData = [ "provider": credential.provider ]
                self.completeSignIn(id: (user?.uid)!,userData: userData )
            }
        })
    }
    
    func completeSignIn(id: String,userData: Dictionary<String,String> ) {
        
        DataServices.instance.createFirebaseDBUser(id: id, userData: userData)
        let KeychainWrapperResult = KeychainWrapper.standard.set(id, forKey: Constants.KEY_UID)
        print("The REsult of the keychain wrapper is \(KeychainWrapperResult)")
        doSegueMan()
        
    }
    //======================================== Firebase AUTH Stuffs ENDS ====================================
    
    
    
    
    //sign in and next is signup
    @IBAction func signIn(_ sender: Any) {
        if emailLabel.text != "" && passwordLabel.text != "" {
            AuthProvider.instance.login(emailId: emailLabel.text!, password: passwordLabel.text!, loginhandler: { (message) in
                if message != nil {
                    self.alertTheUser(title: "Authentication Error!", message: message!)
                } else {
                    self.emailLabel.text = ""
                    self.passwordLabel.text = ""
                    let KeychainWrapperResult = KeychainWrapper.standard.set("ramram", forKey: Constants.KEY_UID)
                    print("The REsult of the keychain wrapper is \(KeychainWrapperResult)")
                    doSegueMan()
                }
            })
        } else {
            self.alertTheUser(title: "Alert!", message: "Authentication Error Kindly complete the text fields")
        }
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        
        if emailLabel.text != nil && passwordLabel.text != nil {
            AuthProvider.instance.signUp(emailId: emailLabel.text!, password: passwordLabel.text!, loginHandler: { (message) in
                if message != nil {
                    self.alertTheUser(title: "Problem creating the new user", message: message!)
                } else {
                    self.emailLabel.text = ""
                    self.passwordLabel.text = ""
                    print("Done man Done")
                    doSegueMan()
                }
            }) } else {
            self.alertTheUser(title: "Alert!", message: "Authentication Error Kindly complete the text fields")
        }
    }
    
    func alertTheUser(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil);
        
    } // alert the user
    
    
    
    
}


























