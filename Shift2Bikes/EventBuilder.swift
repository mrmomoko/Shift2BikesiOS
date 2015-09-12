//
//  EventBuilder.swift
//  Shift2Bikes
//
//  Created by Momoko Saunders on 9/12/15.
//  Copyright (c) 2015 Momoko Saunders. All rights reserved.
//

import Foundation

class EventBuilder : NSObject {
    var events = [CalendarEvent]()
    let mySpecialNotificationKey = "com.andrewcbancroft.specialNotificationKey"
    
    func pullDownEvents() {
        let path = "http://stevekirkendall.info/~shift/cal/viewjson.php"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: path)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSArray
            
            if (jsonResult != nil) {
                self.events = self.createEventsWithJSON(jsonResult!)
            } else {
                // couldn't load JSON, look at error
            }
        })
    }
    
    func createEventsWithJSON(json: NSArray) -> [CalendarEvent] {
        var events = [CalendarEvent]()
        for object in json {
            var event = CalendarEvent()
            event.title = object.valueForKey("tinytitle") as? String
            event.eventDescription = object.valueForKey("printdescr") as? String
            event.date = object.valueForKey("eventdate") as? String
            event.location = object.valueForKey("address") as? String
            events.append(event)
        }
        if events.count == json.count {
        // post that we have results
            NSNotificationCenter.defaultCenter().postNotificationName(mySpecialNotificationKey, object: self)
            self.events = events
        }
        return events
    }
}
