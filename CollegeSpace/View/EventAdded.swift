//
//  EventAdded.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 17/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EventAdded: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var votes:UILabel!
    
    var postRef:DatabaseReference!
    
    func configureCell(eventCell:EventCell) {
        dateLbl.text = eventCell.date
        time.text = eventCell.time
    }
    
    func configureCell2(eventCell:EventCell) {

        postRef = DataServices.instance.Events.child(eventCell.date).child(eventCell.time)
        dateLbl.text = eventCell.date
        time.text = eventCell.time
        votes.text = eventCell.votes
    }
}
