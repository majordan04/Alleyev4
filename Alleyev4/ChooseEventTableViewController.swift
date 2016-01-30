//
//  ChooseEventTableViewController.swift
//  Alleyev4
//
//  Created by Matthew Jordan on 1/3/16.
//  Copyright © 2016 Matthew Jordan. All rights reserved.
//

import UIKit

class ChooseEventTableViewController: UITableViewController {
    
    
    var events:[String] = [
        "Accident",
        "Assault",
        "Fire",
        "Harassment",
        "Robbery",
        "Suspicious Activity",
        "Theft",
        "Vandalism",
        "Other"]
    
    // send any data back, so you’ll have to add a new unwind segue for that
    // add properties to hold the name and the index of the currently selected event
    var selectedEvent:String? {
        didSet {
            if let event = selectedEvent {
                selectedEventIndex = events.indexOf(event)!
            }
        }
    }
    var selectedEventIndex:Int?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source. WILL NOT SEE TABLE WITHOUT IT
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    
    
    
    // STEP 1: This sets a checkmark on the cell that contains the name of the currently selected game
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = events[indexPath.row]
        
        if indexPath.row == selectedEventIndex {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    //This method is called by the Table View delegate whenever the user taps a row. First this method deselects the row after it was tapped. That makes it fade from the gray highlight color back to the regular white. Then it removes the checkmark from the cell that was previously selected, and puts it on the row that was just tapped.

        
        

    
    
    // STEP 2: https://www.youtube.com/watch?v=pHG6tQYFU6I
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "SaveCategory" {
            
            if let destination = segue.destinationViewController as? AddEventViewController {
                
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRowAtIndexPath(path!)
                destination.EventTypeViaSegue = (cell?.textLabel?.text!)!
            }
        }
        
        
    }

    
    
    
}

