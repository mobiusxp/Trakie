//
//  TrackingEventVC.swift
//  Trakie
//
//  Created by Khoa Nguyen on 12/6/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import UIKit
import MapKit;
import CoreLocation;

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
        setMapLocation();
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Set the map view location based on the event data
    func setMapLocation(){
        let geocoder = CLGeocoder();
        if (event!.eventCity! == "N/A" && event!.eventState! == "N/A") || (event!.eventCity! == "N/A" && event!.eventState! != "N/A"){
            
        }else if event!.eventCity! == "N/A" && event!.eventState! != "N/A"{
        
            geocoder.geocodeAddressString(event!.eventState!, completionHandler: {(placemarks,error) in
                if error != nil{
                    print("geocode error");
                }
                let pm = placemarks as [CLPlacemark]!;
                if pm.count > 0{
                    var mark:CLPlacemark = pm![0];
                    var coordinates:CLLocationCoordinate2D = mark.location!.coordinate;
                    var annotation:MKPointAnnotation = MKPointAnnotation();
                    annotation.coordinate = coordinates;
                    annotation.title = "\(self.event!.event!)";
                    self.eventMapView!.addAnnotation(annotation);
                    self.eventMapView?.centerCoordinate = coordinates;
                    self.eventMapView?.selectAnnotation(annotation, animated: true);
                    
                }
                
            });
            
        }else{
            
            geocoder.geocodeAddressString("\(event!.eventCity!), \(event!.eventState!)", completionHandler: {(placemarks,error) in
                if error != nil{
                    print("geocode error");
                }
                let pm = placemarks as [CLPlacemark]!;
                if pm.count > 0{
                    var mark:CLPlacemark = pm![0];
                    var coordinates:CLLocationCoordinate2D = mark.location!.coordinate;
                    var annotation:MKPointAnnotation = MKPointAnnotation();
                    annotation.coordinate = coordinates;
                    annotation.title = "\(self.event!.event!)";
                    self.eventMapView!.addAnnotation(annotation);
                    self.eventMapView?.centerCoordinate = coordinates;
                    self.eventMapView?.selectAnnotation(annotation, animated: true);
                    
                }
                
            });
            
        }
    
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
