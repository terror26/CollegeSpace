//
//  FirstViewController.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 16/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import UIKit
import JTAppleCalendar

class FirstViewController: UIViewController {
    let formatter = DateFormatter();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
//
//extension FirstViewController:JTAppleCalendarViewDelegate,JTAppleCalendarViewDataSource {
//
//    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
//    }
//
//    public func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
//
//        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as!CustomCell
//        cell.dateLBl.text = cellState.text
//        return cell
//
//    }
//
//    public func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
//
//        formatter.dateFormat = "yyyy MM dd"
//        formatter.timeZone = Calendar.current.timeZone
//        formatter.locale = Calendar.current.locale
//
//        let startdate = formatter.date(from: "2018 01 01")!
//        let enddate = formatter.date(from: "2018 12 31")!
//        let parameters = ConfigurationParameters(startDate: startdate, endDate: enddate)
//        return parameters
//    }
//

    
    

