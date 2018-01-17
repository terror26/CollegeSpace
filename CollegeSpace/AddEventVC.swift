//
//  SecondViewController.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 16/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import UIKit

class AddEventVC: UIViewController {

    @IBOutlet weak var eventdateTime: UITextField!
    @IBOutlet weak var durationLbl: UITextField!
    @IBOutlet weak var locationLbl: UITextField!
    let datePicker = UIDatePicker()
    
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
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        eventdateTime.text =  formatter.string(from: datePicker.date)
        self.view.endEditing(true);
    }
}




























