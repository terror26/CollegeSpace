//
//  EventCell.swift
//  CollegeSpace
//
//  Created by Kanishk Verma on 17/01/18.
//  Copyright © 2018 Kanishk Verma. All rights reserved.
//

import Foundation

class EventCell {
    
    private var _date:String!
    private var _location:String!
    private var _starttime:String!
    private var _endtime:String!
    
    var date:String {
        return _date
    }
    
    var location:String {
        return _location
    }
    
    var starttime:String {
        return _starttime
    }
    
    var endtime:String {
        return _endtime
    }
    
    init(date:String!, location:String, starttime:String, endtime:String) {
        self._date = date
        self._location = location
        self._starttime = starttime
        self._endtime = endtime
    }
    
}
