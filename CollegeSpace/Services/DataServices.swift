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
import SwiftKeychainWrapper

protocol implementMeSessions:class {
    func getSessionDetails(sessions:[EventCell]?)
    
}
protocol implementmeAll:class {
    func getAllDetails(Schedule:[EventCell]?)
}


var DB_BASE = Database.database().reference()

class DataServices {
    
    private static let _instance = DataServices();
    private init(){};
    
    weak var delegate:implementMeSessions?
    weak var delegate2:implementmeAll?
    
    
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
    func createFirebaseSpeakerUser(id:String, speakerData: Dictionary<String,String>) {            //Check where u wanna use it or not
        Users.child(id).updateChildValues(speakerData)
    }//create firebase speaker
    
    func createFirebaseDBUser(id:String,userData: Dictionary<String,String>) {
        Users.child(id).updateChildValues(userData)
        
    }//create firebaseDBUSer
    
    func saveUser(withID:String, email:String, password:String) {
        let data :Dictionary<String,Any> = [
            Constants.EMAIL: email,
            Constants.password : password
        ]
        Users.child(withID).setValue(data)
    }//Save user for our signup method
    
    func saveMeetingTime(date:String, time:String,votes:Int) {
        //retrieve the votes
        Events.child(date).child(time).updateChildValues(["UUID" :AuthProvider.instance.userUID(),Constants.Votes: (votes+1)])
    }//save in Events
    
    
    func saveInNames(emailid:String, date:String, time:String) {
        print("the emailid sent is \(emailid) & the email id in keychainwrapper is \(KeychainWrapper.standard.string(forKey: Constants.EMAILIDCURRENT))")
        names.child(emailid).child(date).child(Constants.Time).updateChildValues([time:true]);
    }//save in Names
    
    
    func populateSessions() {
        names.observeSingleEvent(of: .value) { (snapshot) in
            var sessions = [EventCell]()
            
            if let result = snapshot.value as?NSDictionary {
                for (_Name,value) in result {
                    
                    let check = _Name as! String
                    print("The check is \(check)")
                    print("The emailid current is \(KeychainWrapper.standard.string(forKey:Constants.EMAILIDCURRENT) )")
                    if check == KeychainWrapper.standard.string(forKey: Constants.EMAILIDCURRENT) {
                        _ = _Name as! String
                        if let _value1 = value as?NSDictionary {
                            for (_Date,value1) in _value1 {
                                print("the date is \(_Date) the value1 is \(value1)")
                                
                                if let _value2 = value1 as?NSDictionary {
                                    for (key2,value2) in _value2 {
                                        print("-------\(key2) is \(value2)------")
                                        if let _value3 = value2 as?NSDictionary {
                                            for (_Time,_) in _value3  {
                                                print("++++++ Finally,The time is \(_Time)")
                                                
                                                let firstSession = EventCell(date: _Date as! String,time: _Time as! String)
                                                sessions.append(firstSession)
                                            }
                                        }
                                    }
                                }
                            }
                        }// _value1
                    }
                }
            }
            self.delegate?.getSessionDetails(sessions: sessions)
            
        }//snapshot
    }//populatesession
    
    
    func populateSchedule() {
        Events.observeSingleEvent(of: .value) { (snapshot) in
            var Schedule = [EventCell]()            
            if let result = snapshot.value as?NSDictionary {
                
                for(_date,value) in result {
                    print("The date is \(_date)")
                    
                    if let _value2 = value as?NSDictionary {
                        
                        for (_time,valuex) in _value2 {
                            print("++++++ Finally,The time is \(_time)")
                            
                            if let dict  = valuex as?NSDictionary {
                                let comparablestuff = "\(dict[Constants.Votes]!)"
                                
                                print("the Votes are \(comparablestuff)")
                                let firstsession = EventCell(date: _date as!String, time: _time as!String)
                                firstsession.configureEventCell(date: _date as! String, time: _time as! String, votes: comparablestuff )
                                Schedule.append(firstsession)
                            } // dict valuex
                        }
                    }
                } //_date result
            }
            self.delegate2?.getAllDetails(Schedule: Schedule);
        } //snapshot
    }//poputlateScedhule
    
    
    func saveinfo(date:String, time:String,votes:Int) -> Bool {
        var test :Bool = true;
        
        Users.observeSingleEvent(of: .value) { (snapshot) in
            if let result = snapshot.value as?NSDictionary {
                if let currentUser = result[AuthProvider.instance.userUID()] as?NSDictionary {
                    print("yoman")
                    
                    if let inside = currentUser[Constants.EMAIL] as?NSString {
                        if inside != "" {
                            var email:String = ""
                            let emaildemo : String = inside as String
                            
                            for Character in emaildemo {
                                if Character == "@" {
                                    break
                                } else {
                                    email += "\(Character)"
                                }
                            }
                            
                            self.saveMeetingTime(date: date, time: time,votes: votes)
                            self.saveInNames(emailid: email, date: date, time: time)
                            print("test is \(test)")
                            
                        } else {
                            test = false
                            print("test is \(test)")
                        }
                    }
                }
            }
        }
        return test
    }//save info end

    func checkforVotes(required:EventCell) {
        
        Events.child(required.date).child(required.time).observeSingleEvent(of: .value) { (snapshot) in
            if let result = snapshot.value as?NSDictionary {
                
                if let votes = result[Constants.Votes] as?Int {
                    if votes == 1 {
                        self.Events.child(required.date).child(required.time).removeValue()
                    } else {
                        let changed = votes - 1 ;
                        self.Events.child(required.date).child(required.time).child(Constants.Votes).setValue(changed)

                    }
                }
            }
        }
    }
    
    
} // Database Services





































