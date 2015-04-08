//
//  SendMessageViewController.swift
//  ELHS Sports
//
//  Created by Alex Atwater on 4/6/15.
//  Copyright (c) 2015 Alex Atwater. All rights reserved.
//

import UIKit
import Parse

class SendMessageViewController: UIViewController {

    @IBOutlet weak var notiTitle: UITextField!
    @IBOutlet weak var notiMessage: UITextField!
    @IBOutlet weak var adminPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @IBAction func sendMessage(sender: UIBarButtonItem) {
        
        //call the backend function and send the data
        
        let messageData:NSDictionary = NSDictionary(dictionary: ["messageTitle" : notiTitle.text, "message" : notiMessage.text, "password" : adminPass.text])
        PFCloud.callFunctionInBackground("sendMessage", withParameters: messageData) { (result:AnyObject!, error:NSError!) -> Void in
            
            var message:String?
            
            if (error == nil) {
                //success
                message = result as? String
                
                
            } else {
                //error
                message = "There was an error. Message from server: \(error.userInfo)"
            }
            
            if let displayMessage = message {
                
                
                let alert = UIAlertView()
                alert.title = "Server Response"
                alert.message = displayMessage
                alert.addButtonWithTitle("Okay")
                alert.show()
                
                
                
            }
            
        }
        
        
    }
}
