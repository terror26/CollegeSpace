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
    @IBOutlet weak var time: UILabel!
    
    func configureCell(eventCell:EventCell) {
        dateLbl.text = eventCell.date
        time.text = eventCell.time
    }
    
}
