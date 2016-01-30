//
//  AddEventViewController.swift
//  Alleyev4
//
//  Created by Matthew Jordan on 1/3/16.
//  Copyright © 2016 Matthew Jordan. All rights reserved.
//

import UIKit
import Parse



class AddEventViewController: UITableViewController,UITextViewDelegate {
    
    
    //Changes the label to what the user selected in the ChooseEvent Table View
    @IBOutlet var EventTypeLabel: UILabel!
    
    var EventTypeViaSegue = ""
    
    
    
    //Event Details outlet
    @IBOutlet var EventDetailsTextField: UITextView!
    
    
    //Character Count for Event Details
    
    @IBOutlet var CharacterCount: UILabel!
    

    
    
    @IBOutlet weak var addLocation: UIView!
    
    @IBOutlet weak var LocationLabel: UILabel!
    
    var LocationLabeltext = String ()
    
    //Tempo
    required init?(coder aDecoder: NSCoder) {
        print("init AddEventViewController")
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("deinit AddEventViewController")
    }
    
    
    // tap anywhere in the row to bring up the keyboard: tableView(_:didSelectRowAtIndexPath:)
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            EventDetailsTextField.becomeFirstResponder()
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Set var above to label for "prepare for segue"
        EventTypeLabel.text = EventTypeViaSegue
        
        
        //For Character Count
        EventDetailsTextField.delegate = self
        
        //Add Location
        LocationLabel.text = LocationLabeltext
        
        
    }
    
    @IBAction func postPost(sender: AnyObject) {
        
        Post()
    }
    
    
    func Post(){
        // Dismiss keyboard and capture any auto-correct
        
        
        
        var event:PFObject = PFObject(className: "event")
        
        //Capture Event Details
        event["EventDetails"] = EventDetailsTextField.text!
        
        //Capture Category
        event["EventCategory"] = EventTypeLabel.text!
        
        // Get the currently logged in PFUser
        event["Username"] = PFUser.currentUser()
        
        // Capture Location
        event["Location"] = LocationLabel.text!

        
        
        
        
        //Return user to MapView
        event.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                
                // The object has been saved.
            } else {
                
                // There was a problem, check error.description
            }
        }
        
        self.navigationController?.storyboard
    }
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Table view data source
    
    
    //EventDetail Character Count
    func textView(textview: UITextView,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool{
            
            var newLength:Int = (textview.text as NSString).length + (text as NSString).length - range.length
            var remainingChar:Int = 140 - newLength
            
            CharacterCount.text = "\(remainingChar)"
            
            //Message is more than 140 characters
            return (newLength >= 140) ? false : true
            
            return true
    }
    
}