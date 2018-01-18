//
//  ProfileVC.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 18/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//
//
//  ProfileVC.swift
//  FinalConferenceApp
//
//  Created by Kanishk Verma on 04/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    //Gmail sign out Button
    @IBAction func signOutBtn(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: Constants.KEY_UID)
        if AuthProvider.instance.isLogOut() {
            AuthProvider.instance.logout()
            logout()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true);
    }
    
    func logout() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LogInVC") as!SignInVC
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC ;
    }
    
    
}

