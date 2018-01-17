//
//  EventAdded.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 17/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import UIKit

class EventAdded: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var starttimeLbl: UILabel!
    @IBOutlet weak var endtimeLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    func configureCell(eventCell:EventCell) {
        dateLbl.text = eventCell.date
        starttimeLbl.text = eventCell.starttime
        endtimeLbl.text = eventCell.endtime
        locationLbl.text = eventCell.location
    }
    
}
