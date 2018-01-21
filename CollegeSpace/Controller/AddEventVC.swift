//
//  SecondViewController.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 16/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import UIKit

protocol implementSaved {
    func getbackSaved(Event:EventCell?)
}

class AddEventVC: UIViewController {
    
    @IBOutlet weak var eventdateTime: UITextField!
    @IBOutlet weak var endTimeLbl: UITextField!
    @IBOutlet weak var startTimeLbl: UITextField!
    @IBOutlet weak var AmPmLbl: UITextField!
    
    var delegatesaved:implementSaved?
    let datePicker = UIDatePicker()
    var pickerView = UIPickerView()
    var pickerView2 = UIPickerView()
    
    let cell = EventCell(date: "8/10/12",time:"10-11Am")
    var timedata = ["1","2","3","4","5","6","7","8","9","10","11","12"];
    var data = ["AM","PM"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView2.dataSource = self
        pickerView2.delegate = self
        startTimeLbl.inputView = pickerView2
        endTimeLbl.inputView = pickerView2
        AmPmLbl.inputView = pickerView
        createdatePicker()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func eventTextFieldPressed(_ sender: Any) {
        createdatePicker()
    }
    
    func createdatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerShow))
        toolbar.setItems([doneButton], animated: false)
        
        eventdateTime.inputAccessoryView = toolbar
        //assigning datePicker to the textField
        eventdateTime.inputView = datePicker
        
        //to format the date and time only in easy
        datePicker.datePickerMode = .date
    }
    
    @objc func datePickerShow() {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        eventdateTime.text = formatter.string(from: datePicker.date)
        
        let demo:String =  formatter.string(from: datePicker.date)
        var result:String = ""
        
        for Character in demo {
            if Character  != "/" {
                result += String(Character)
            } else {
                result += "-"
            }
        }
        
        self.view.endEditing(true);
    }
    
    @IBAction func SaveBtnPressed(_ sender: UIButton) {
        if eventdateTime.text != ""  && startTimeLbl.text != "" && endTimeLbl.text != ""  {
            
            print("Yoyoy")
            let change = eventdateTime.text!
            var correct:String = ""
            
            for Character in change {
                if Character == "/" {
                    correct += "-"
                } else {
                    correct += "\(Character)"
                }
            }
            
            let timecorrect = "\(startTimeLbl.text!)-\(endTimeLbl.text!)\(AmPmLbl.text!)"
            print("the time and date sent is \(correct) \(timecorrect)")
            var changed :Bool = true
            DataServices.instance.Events.child(correct).child(timecorrect).observeSingleEvent(of: .value, with: { (snapshot) in
                if let result = snapshot.value as?NSDictionary {
                    
                    if let _vote = result[Constants.Votes]  {
                        
                        self.saveandAlert(_vote: _vote as! Int,time:timecorrect, date:correct)
                    }
                }
            })

            print("´´´´´´´´´´ the changed is \(changed) ´´´´´´´´´´´´´")
            if (changed) {
                self.saveandAlert(_vote: 0, time: timecorrect, date: correct)
                
            }} else {
            self.alertTheUser(title: "Error", message: "Kindly enter all the fields before entering them")
        }
    }//saveBtnPressed ends
    
    
    func saveandAlert(_vote:Int, time:String, date:String) {
        
        if DataServices.instance.saveinfo(date: date, time: time,votes: _vote as!Int) {
            self.alertTheUser(title: "Successfully", message: "Data stored successfully")
            let firstevent = EventCell(date: date, time: time)
            self.delegatesaved?.getbackSaved(Event: firstevent)
            
        } else {
            self.alertTheUser(title: "Sorry ", message: "Network Authentication Error")
        }
    }
        
    func alertTheUser(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}


extension AddEventVC:UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (AmPmLbl.isEditing) {
            return data.count
        } else {
            return timedata.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (AmPmLbl.isEditing) {
            return data[row]
        } else {
            return timedata[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (AmPmLbl.isEditing) {
            AmPmLbl.text =  data[row]
        } else {
            if (startTimeLbl.isEditing) {
                startTimeLbl.text = timedata[row]
            } else {
                endTimeLbl.text = timedata[row]
            }
        }
    }
}
























