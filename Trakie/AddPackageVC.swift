//
//  AddPackageVC.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/3/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import UIKit

class AddPackageVC: UIViewController {

    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var trackingNumberField: UITextField!
    @IBOutlet weak var packageNameField: UITextField!
    @IBOutlet weak var notesArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveItem(sender: AnyObject) {
        // print("Save invoked!");
        let validator = Validator();
        if(validator.validateTracking(trackingNumberField!.text!, service: ServiceType.USPS)){
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            let dataManager = appDelegate.dm!;
            
            dataManager.saveNewPackage(trackingNumberField!.text!, name: packageNameField!.text!, notes: notesArea!.text!, svcType: ServiceType.USPS);
            
            navigationController?.popViewControllerAnimated(true);
        }else{
            let alertController = UIAlertController(title: "Invalid Tracking Number", message:
                "This tracking number is invalid, please try again.", preferredStyle: UIAlertControllerStyle.Alert);
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil));
            
            self.presentViewController(alertController, animated: true, completion: nil);
        }

    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("this happened");
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
