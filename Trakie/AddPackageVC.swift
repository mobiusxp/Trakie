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
        let formattedNumber = trackingNumberField!.text!.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil);
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
    //  appDelegate.packages!.co
        if(validator.validateTracking(formattedNumber, service: ServiceType.USPS)){
            
            
            let dataManager = appDelegate.dm!;
            
            do{
                try dataManager.saveNewPackage(formattedNumber, name: packageNameField!.text!, svcType: ServiceType.USPS);
                navigationController?.popViewControllerAnimated(true);
            }catch let e as ErrorType{
                let alertController = UIAlertController(title: "Invalid Package", message:
                    "This package is not in the USPS system. Please check your tracking number.", preferredStyle: UIAlertControllerStyle.Alert);
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil));
                
                self.presentViewController(alertController, animated: true, completion: nil);
            }
            
        }else{
            let alertController = UIAlertController(title: "Invalid Tracking Number", message:
                "This tracking number is invalid, please try again.", preferredStyle: UIAlertControllerStyle.Alert);
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil));
//            
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
