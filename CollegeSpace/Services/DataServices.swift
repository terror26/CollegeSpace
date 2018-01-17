//
//  DataServices.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 17/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

protocol implementMeSessions:class {
    func getSessionDetails(sessions:[EventCell])
}

var DB_BASE = Database.database().reference()

class DataServices {
    
    private static let _instance = DataServices();
    private init(){};
    
    var delegate:implementMeSessions?
    
    static var instance:DataServices {
        return _instance
    }
    private var _Users:DatabaseReference = DB_BASE.child(Constants.Users)
    private var _Events:DatabaseReference = DB_BASE.child(Constants.Events)
    private var _names:DatabaseReference = DB_BASE.child(Constants.names)
    private var _nameTime:DatabaseReference = DB_BASE.child(Constants.nameTime);
    
    var Users:DatabaseReference {
        return _Users
    }
    
    var Events:DatabaseReference {
        return _Events
    }
    
    var nameTime:DatabaseReference {
        return _nameTime
    }
    
    var names:DatabaseReference {
        return _names
    }
    
    func saveInFirebaseNames(Name:String, date:String, time:String) {
        
        let data = [date:"", Constants.names: time];
        names.child(Name).updateChildValues(data);
    }
    
    func populateSessions() {
        
        Users.observeSingleEvent(of: .value) { (snapshot) in
            print("\(snapshot.value)")
            
        }
    }
}















