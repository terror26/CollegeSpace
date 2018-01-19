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
    private var _time:String!
    
    var date:String {
        return _date
    }
    

    
    var time:String {
        return _time
    }
 
    init(date:String!,time:String) {
        self._date = date
        self._time = time
    }
    
}
