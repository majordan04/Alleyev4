//
//  LogInViewController.swift
//  Alleyev4
//
//  Created by Matthew Jordan on 1/9/16.
//  Copyright © 2016 Matthew Jordan. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {
    
    @IBOutlet var UsernameTextField: UITextField!
    
    @IBOutlet var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func LogInBtnAction(sender: AnyObject) {
        
        LogIn()
        
    }
    
    func LogIn(){
        var user = PFUser()
        user.username = UsernameTextField.text!
        user.password = PasswordTextField.text!
        
        
        PFUser.logInWithUsernameInBackground(UsernameTextField.text!, password: PasswordTextField.text!, block: {
            (User : PFUser?, Error : NSError?) -> Void in
            
            if Error == nil{
                dispatch_async(dispatch_get_main_queue()){
                    var Storyboard = UIStoryboard(name: "Main", bundle: nil)
                    var MainVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("MainVC") as!
                    UIViewController
                    
                    self.presentViewController(MainVC, animated: true, completion: nil)
                }
            }
                
            else {
                
                NSLog("Wrong!!")
            }
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
