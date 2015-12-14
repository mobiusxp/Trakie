//
//  TrackingEventVC.swift
//  Trakie
//
//  Created by Khoa Nguyen on 12/6/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import UIKit
import MapKit;

class TrackingEventVC: UIViewController {
    
    var event:TrackingEvent?;
    
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    @IBOutlet weak var eventMapView: MKMapView!
    
    override func viewDidLoad() {
        
        eventLabel!.text = "\(event!.event!)";
        eventLabel!.adjustsFontSizeToFitWidth = true;
        
        dateLabel!.text = "\(event!.eventDate!) \(event!.eventTime!)";
        eventLocationLabel!.text = "\(event!.eventCity!) , \(event!.eventState!)";
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

}
