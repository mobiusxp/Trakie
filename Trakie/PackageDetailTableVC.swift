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

    var selectedPackage:NSManagedObject?;
    var packageEvents:NSArray?;
    var sec1:[String]?
    var sec3:[String]?
    
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
            return 1;
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
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
            cell.textLabel!.text = selectedPackage!.valueForKey("trackingNumber") as? String;
            
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
                    cell.textLabel!.text = event.valueForKey("event") as? String;
                cell.detailTextLabel!.text = "\(event.valueForKey("eventDate") as? String) \(event.valueForKey("eventTime") as? String) - \(event.valueForKey("eventCity") as? String), \(event.valueForKey("eventState") as? String)";
                }else{
                    cell.textLabel!.text = "No tracking information available";
                }
                
                return cell;
            }
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath)
            if(packageEvents != nil){
                let event = packageEvents![indexPath.row] as! TrackingEvent;
                cell.textLabel!.text = event.valueForKey("event") as? String;
                cell.detailTextLabel!.text = "\(event.valueForKey("eventDate") as? String) \(event.valueForKey("eventTime") as? String) - \(event.valueForKey("eventCity") as? String), \(event.valueForKey("eventState") as? String)";
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
