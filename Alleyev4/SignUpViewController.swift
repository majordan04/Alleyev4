//
//  SignUpViewController.swift
//  Alleyev4
//
//  Created by Matthew Jordan on 1/14/16.
//  Copyright © 2016 Matthew Jordan. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet var UsernameTextField: UITextField!
    
    @IBOutlet var EmailAddressTextField: UITextField!
    
    @IBOutlet var PasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func SignUpBtnAction(sender: AnyObject) {
        
        SignUp()
    }
    
    func SignUp(){
        var user = PFUser()
        user.username = UsernameTextField.text!
        user.password = PasswordTextField.text!
        user.email = EmailAddressTextField.text!
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
            } else {
                // Examine the error object and inform the user.
            }
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
