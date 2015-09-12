//
//  CalendarEvent.swift
//  Shift2Bikes
//
//  Created by Momoko Saunders on 9/12/15.
//  Copyright (c) 2015 Momoko Saunders. All rights reserved.
//

import Foundation

class CalendarEvent: NSObject {
    var title : String?
    // for now we'll make it a string, but soon, something more!
    //let location : NSLocale?
    var location : String?
    // same with date. just for now
    //let date : NSDate
    var date : String?
    var eventDescription : String?
    
    override init() {
        title = "title"
        location = "location"
        date = "date"
        eventDescription = "eventDescription"
        super.init()
    }
}
