//
//  PackageDetailTableVC.swift
//  Trakie
//
//  Created by Khoa Nguyen on 12/6/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import UIKit
import CoreData

class PackageDetailTableVC: UITableViewController{

    // @IBOutlet weak var deleteItem: UIBarButtonItem!
    var selectedPackageIndex:Int?;
    var selectedPackage:NSManagedObject?;
    var packageEvents:NSArray?;
    var sec1:[String]?
    var sec3:[String]?
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        self.title = selectedPackage!.valueForKey("name") as? String;
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if(selectedPackage!.valueForKey("notes") as? String != nil){
            return 3;
        }else{
            return 2;
        }
        // return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // return 0
        // print("Section \(section)");
        switch section{
        case 0:
            return 2;
        case 1:
            if(selectedPackage!.valueForKey("notes") as? String != nil){
                return 1;
            }else{
                return packageEvents!.count;
            }
        case 2:
            if(packageEvents != nil){
                return packageEvents!.count;
            }else{
                return 1;
            }
        default:
            return 0;
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
          
        // Configure the cell...
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath);
            cell.selectionStyle = UITableViewCellSelectionStyle.None;
            if(indexPath.row == 0){
                cell.textLabel!.text = selectedPackage!.valueForKey("trackingNumber") as? String;
            }else{
                let selectedPackageType = ((selectedPackage! as! Package).svcType);
                cell.textLabel!.text = ServiceType(rawValue: Int32(selectedPackageType!.integerValue))?.description;
            }
            
            return cell;
        case 1:
            if(selectedPackage!.valueForKey("notes") != nil){
                let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
                if(selectedPackage!.valueForKey("notes") != nil){
                    cell.textLabel!.text = selectedPackage!.valueForKey("notes") as? String;
                }else{
                    cell.textLabel!.text = "";
                }
                return cell;
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath)
                if(packageEvents != nil){
                    let event = packageEvents![indexPath.row] as! TrackingEvent;
                    // print(event.event!);
                    cell.textLabel!.text = event.event!;
                cell.detailTextLabel!.text = "\(event.eventDate!) \(event.eventTime!) - \(event.eventCity!), \(event.eventState!)";
                }else{
                    cell.textLabel!.text = "No tracking information available";
                }
                
                return cell;
            }
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath)
            if(packageEvents != nil){
                let event = packageEvents![indexPath.row] as! TrackingEvent;
                cell.textLabel!.text = event.event!;
                cell.detailTextLabel!.text = "\(event.eventDate!) \(event.eventTime!) - \(event.eventCity!), \(event.eventState!)";
            }else{
                cell.textLabel!.text = "No tracking information available";
            }
            return cell;
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
            cell.textLabel!.text = "error";
            return cell;
        }

        // return cell
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Tracking Number";
        case 1:
            if(selectedPackage!.valueForKey("notes") != nil){
                return "Notes";
            }else{
                return "Tracking Events";
            }
        case 2:
            return "Tracking Events";
        default:
            return "error";
        }
    }
    
    
    @IBAction func deleteItem(sender: AnyObject) {
        let deleteAlert = UIAlertController(title:"Delete Package?", message: "Remove this package?", preferredStyle:UIAlertControllerStyle.Alert);
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let dm = appDelegate.dm!;
        
        deleteAlert.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: {(action: UIAlertAction!) in
            dm.deleteCDPackage(self.selectedPackageIndex!);
            self.navigationController?.popToRootViewControllerAnimated(true);
        }));
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: {(action: UIAlertAction!) in
            // print("canceled");
        }));
        
        self.presentViewController(deleteAlert, animated: true, completion: nil);
    }

    @IBAction func shareTapped(sender: AnyObject) {
        let textToShare = "\((selectedPackage as! Package).trackingNumber!)";
        
        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/")
        {
            let objectsToShare = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
            //
            
            if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone {
                self.presentViewController(activityVC, animated: true, completion: nil);
            }else{
                let popup: UIPopoverController = UIPopoverController(contentViewController: activityVC)
                popup.presentPopoverFromRect(CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 4, 0, 0), inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
            }
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
