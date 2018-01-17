//
//  SecondViewController.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 16/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import UIKit

protocol implementMe {
    func getInfoforTime(date:String?, location:String?, starttime: String?, endtime:String?)
}

class AddEventVC: UIViewController {

    @IBOutlet weak var eventdateTime: UITextField!
    @IBOutlet weak var endTimeLbl: UITextField!
    @IBOutlet weak var startTimeLbl: UITextField!
    @IBOutlet weak var locationLbl: UITextField!
    
    let datePicker = UIDatePicker()
    var delegate:implementMe?
    let cell = EventCell(date: "8/10/12", location: "bengal", starttime: "10:00Am", endtime: "11:00Am")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createdatePicker()
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
        if eventdateTime.text != nil  && startTimeLbl.text != nil && endTimeLbl.text != nil && locationLbl.text != nil {
            
            self.delegate?.getInfoforTime(date: eventdateTime.text!, location: locationLbl.text!, starttime: startTimeLbl.text!, endtime: endTimeLbl.text!)
            
        } else {
            //some alert popUp
        }
    }
    
    
}




























