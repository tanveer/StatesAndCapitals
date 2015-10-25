//
//  StartingViewController.swift
//  StatesAndCapitals
//
//  Created by Tanveer Bashir on 10/24/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController{
    
    @IBOutlet weak var nameField: UITextField!
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    @IBAction func cancelToStartingViewController(segue: UIStoryboardSegue){
        nameField.text = ""
    }

//  MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let identifier = "MAIN"
        if segue.identifier == identifier{
            let mainVC = segue.destinationViewController as! ViewController
            mainVC.name = nameField.text!
        }
    
    }
    
    @IBAction func goButton(sender: UIButton){
        resignFirstResponder()
        let name = nameField.text!
        if name == "" {
            let alert  = UIAlertController(title: "Enter your name", message: "Name field can not be blank", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            
        } else{
            performSegueWithIdentifier("MAIN", sender: sender)
            
        }
    }
}


