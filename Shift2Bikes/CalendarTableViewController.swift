//
//  CalendarTableViewController.swift
//  Shift2Bikes
//
//  Created by Momoko Saunders on 9/12/15.
//  Copyright (c) 2015 Momoko Saunders. All rights reserved.
//

import Foundation
import UIKit


class CalendarTableViewController: UITableViewController {
    
    var eventArray = [CalendarEvent]()
    let eventBuilder = EventBuilder()
    let mySpecialNotificationKey = "com.andrewcbancroft.specialNotificationKey"
    
    @IBAction func pullEvents(sender: AnyObject) {
        eventBuilder.pullDownEvents()
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        EventBuilder().pullDownEvents()
        eventArray = eventBuilder.events
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateNotificationSentLabel", name: mySpecialNotificationKey, object: nil)

    }
    func updateNotificationSentLabel() {
        eventArray = eventBuilder.events
            self.tableView.reloadData()
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CalendarEventCell
        cell.eventTitle.text = eventArray[indexPath.row].title
        cell.eventDescription.text = eventArray[indexPath.row].eventDescription
        cell.date.text = eventArray[indexPath.row].date
        cell.location.text = eventArray[indexPath.row].location
        return cell
    }
    
    override func tableView( tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
}
