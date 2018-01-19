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
    @IBOutlet weak var AmPmLbl: UITextField!
    
    let datePicker = UIDatePicker()
    var pickerView = UIPickerView()
    var delegate:implementMe?
    let cell = EventCell(date: "8/10/12", location: "bengal", starttime: "10:00Am", endtime: "11:00Am")
    
    var data = ["AM","PM"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
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
            self.delegate?.getInfoforTime(date: eventdateTime.text!, location: "yo", starttime: startTimeLbl.text!, endtime: endTimeLbl.text!)
            var change = eventdateTime.text!
            var correct:String = ""
            for Character in change {
                if Character == "/" {
                    correct += "-"
                } else {
                    correct += "\(Character)"
                }
            }
            let timecorrect = "\(startTimeLbl.text!)-\(endTimeLbl.text!)\(AmPmLbl.text!)"
            
            if DataServices.instance.saveinfo(date: correct, time: timecorrect) {
                alertTheUser(title: "Successfully", message: "Data stored successfully")
            } else {
                alertTheUser(title: "Sorry ", message: "Network Authentication Error")
            }
        } else {
            self.alertTheUser(title: "Error", message: "Kindly enter all the fields before entering them")
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
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        AmPmLbl.text = data[row]
    }
    
}
























