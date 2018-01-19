//
//  AuthProvider.swift
//  FinalConferenceApp
//
//  Created by Kanishk Verma on 06/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper
typealias LoginHandler = (_ msg:String?) -> Void;

struct LoginErrorCode {
    
    static let INVALID_EMAIL = "Invalid Email Address,Please Provide a Real Email Address"
    static let WRONG_PASSWORD  = "Wrong Paswword,Enter the Correct password"
    static let  PROBLEM_CONNECTING = "PROBLEM CONECTING TO DATABASE,Please Try Later"
    static let USER_NOT_FOUND = "User not found,Please Register"
    static let EMAIL_ALREADY_IN_USE = "Email alredy in user please use another email"
    static let WEAK_PAASOWORD = "Password should be atleast 6 character Long"
    
} // LoginInErrorCode


class AuthProvider {
    
    private static var _instance = AuthProvider();
    
    static var instance:AuthProvider {
        return _instance;
    }
    
    func userUID() -> String{
        return Auth.auth().currentUser!.uid;
    }
    
    func isLogOut() -> Bool {
        if Auth.auth().currentUser?.uid != nil {
            return true
        }
        return false
        
    } // isLogOut
    
    func logout()  {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
            } catch {
                print(" ++++++++++ Some error with the signout occured ++++++++");
            }
        }
        
    } // logout
    
    
    func login(emailId:String, password:String , loginhandler:LoginHandler?) {
        
        Auth.auth().signIn(withEmail: emailId, password: password) { (user, error) in
            if error != nil {
                self.handleError(error: error as! NSError, loginHandler: loginhandler)
                print(" +++++++++++ Some error with the authentication with the firebase ++++++++");
            } else {
                loginhandler?(nil)
            }
        }
        
        
    } // login func
    
    func signUp(emailId:String, password:String, loginHandler:LoginHandler?) {
        
        Auth.auth().createUser(withEmail: emailId, password: password) { (user, error) in
            if error != nil {
                self.handleError(error: error as! NSError, loginHandler: loginHandler)
            } else {
                if user?.uid != nil {
                    DataServices.instance.saveUser(withID: user!.uid, email: emailId, password: password)
                    self.login(emailId: emailId, password: password, loginhandler: loginHandler)
                }
            }
        }
    }
    
    private func handleError(error:NSError , loginHandler:LoginHandler?) {
        
        let errCode = AuthErrorCode(rawValue: error.code)
        
        switch errCode {
            
        case .invalidEmail?:
            loginHandler?(LoginErrorCode.INVALID_EMAIL)
            break;
        case .wrongPassword?:
            loginHandler?(LoginErrorCode.WRONG_PASSWORD)
            break;
        case .userNotFound?:
            loginHandler?(LoginErrorCode.USER_NOT_FOUND)
            break;
        case .emailAlreadyInUse?:
            loginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE)
            break;
        case .weakPassword?:
            loginHandler?(LoginErrorCode.WEAK_PAASOWORD)
            break;
            
        default:
            loginHandler?(LoginErrorCode.PROBLEM_CONNECTING)
            break;
            
        }
    }
    
    
}





















