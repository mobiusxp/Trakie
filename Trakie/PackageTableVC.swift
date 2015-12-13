//
//  PackageTableVC.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/3/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import UIKit
import CoreData

class PackageTableVC: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet var packageTable: UITableView!
    var packages:[Package] = [];
    var filteredPackages:[Package] = [Package]();

    override func viewDidLoad() {
        // print(packages[0].name);
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func updateList(sender: AnyObject) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate;
        let dm = appDelegate.dm!;
        dm.updatePackages(packages);
        packages = appDelegate.packages!;
        packageTable.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableView == self.searchDisplayController!.searchResultsTableView{
            return filteredPackages.count;
        }else{
            return packages.count;
        }
        
        // return packages.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("packageCell", forIndexPath: indexPath)
        
        var package:Package;
        if(tableView == self.searchDisplayController!.searchResultsTableView){
            package = filteredPackages[indexPath.row];
        }else{
            package = packages[indexPath.row];
        }
        
        let packageEvents = package.valueForKey("events");
        let lastEvent = packageEvents![0] as! TrackingEvent;
        cell.detailTextLabel?.text = "\(lastEvent.event!) - \(lastEvent.eventDate!) \(lastEvent.eventTime!)";

        // Configure the cell...
        cell.textLabel?.text = package.name!;


        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        // print("view did appear");
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        packages = appDelegate.packages!;
        packageTable.reloadData();
        super.viewDidAppear(false);
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

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let nextVC = segue.destinationViewController as? PackageDetailTableVC{
            let indexPath = tableView.indexPathForSelectedRow;
            // print("You tapped \(indexPath)");
            
            var selectedPackage:Package;
            // print(sender);
            // get the name of the Park
            
            if  self.searchDisplayController!.active{
                let indexPath = self.searchDisplayController?.searchResultsTableView.indexPathForSelectedRow;
                selectedPackage = filteredPackages[indexPath!.row];
            }else{
                selectedPackage = packages[indexPath!.row];
            }
            
            
            // selectedPackage = packages[0];
            // create a new Park Detail Controller and set its properties
            // let detailVC = segue.destinationViewController as! PackageDetailTableVC;
            nextVC.selectedPackageIndex = packages.indexOf(selectedPackage);
            nextVC.selectedPackage = selectedPackage;
            let eventArray = selectedPackage.getArray();
            nextVC.packageEvents = eventArray;
            
            nextVC.sec1 = [selectedPackage.valueForKey("trackingNumber") as! String];
            if(selectedPackage.valueForKey("notes") != nil){
                nextVC.sec3 = [selectedPackage.valueForKey("notes") as! String];
            }else{
                nextVC.sec3 = [];
            }
        }else if let nextVC = segue.destinationViewController as? AddPackageVC{
            
        }
        
        // detailVC.parkIndex =  indexPath!.row;
        
    }
    
    // MARK: - Search
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.filteredPackages = self.packages.filter({( package: Package) -> Bool in
            let stringMatch = package.name!.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch);
            let trackMatch = package.trackingNumber!.rangeOfString(searchText);
            return (trackMatch != nil) || (stringMatch != nil)
        })
    }
    
    
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text!)
        return true
    }
    

}
