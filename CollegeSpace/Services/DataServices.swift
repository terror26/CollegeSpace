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
    
    func populateSessions() {
        names.observeSingleEvent(of: .value) { (snapshot) in
            print("\(snapshot.value)--------")
            
            var sessions = [EventCell]()
            
            if let result = snapshot.value as?NSDictionary {
                for (_Name,value) in result {
                    print("the key is \(_Name) the values is \(value)")
                    
                    if let _value1 = value as?NSDictionary {
                        for (_Date,value1) in _value1 {
                            print("the date is \(_Date) the value1 is \(value1)")
                            
                            if let _value2 = value1 as?NSDictionary {
                                for (key2,value2) in _value2 {
                                    print("-------\(key2) is \(value2)------")
                                    if let _value3 = value2 as?NSDictionary {
                                        for (_Time,_) in _value3  {
                                            print("++++++ Finally,The time is \(_Time)")
                                            var i=0;
                                            var starttime :String = ""
                                            var endtime:String = ""
                                            var amOrpm:String = ""
                                            let time  = _Time as?String
                                            for Character in time! {
                                                if i == 0 {
                                                    starttime += String(Character)
                                                } else if (i==2) {
                                                    endtime += String(Character)
                                                } else if i > 3 {
                                                    amOrpm += String(Character)
                                                }
                                                i += 1
                                            }
                                            let firstSession = EventCell(date: _Date as! String, location: "yoho", starttime: starttime, endtime: endtime)
                                            sessions.append(firstSession)
                                        }
                                    }
                                }
                            }
                        }
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
                        
                        for (_time,_) in _value2 {
                            print("++++++ Finally,The time is \(_time)")
                            var i=0;
                            var starttime :String = ""
                            var endtime:String = ""
                            var amOrpm:String = ""
                            let time  = _time as?String
                            for Character in time! {
                                if i == 0 {
                                    starttime += String(Character)
                                } else if (i==2) {
                                    endtime += String(Character)
                                } else if i > 3 {
                                    amOrpm += String(Character)
                                }
                                i += 1
                            }
                            
                            let firstsession = EventCell(date: _date as! String, location: "Yoyo", starttime: starttime, endtime: endtime)
                            Schedule.append(firstsession)
                        }
                        
                    }
                }
            }
            self.delegate2?.getAllDetails(Schedule: Schedule);
        } //snapshot
    }//poputlateScedhule
    

}






































