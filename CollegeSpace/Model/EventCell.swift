//
//  EventCell.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 17/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import Foundation
import FirebaseDatabase

class EventCell {
    
    private var _date:String!
    private var _time:String!
    private var _votes:String!

    
    
    var date:String {
        return _date
    }
    var time:String {
        return _time
    }
    var votes:String {
        return _votes
    }
    
    init(date:String!,time:String) {
        self._date = date
        self._time = time
        self._votes = "1"
    }
    
    func configureEventCell(date:String, time:String,votes:String) {
        self._date = date
        self._time = time
        self._votes = votes
    }
    
}
