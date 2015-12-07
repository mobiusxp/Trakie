//
//  USPSParser.swift
//  Trakie
//
//  USPS API returns XML so we use an NSXMLParser and use our parser as the delegate
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation
import CoreData

class USPSParser: Parser{
    
    // var XMLParser:NSXMLParser!;
    var parsedPackage:Package?;
    var dm:DataManager?;
    
    
    func parse(package: Package, input:String) -> Package {
        // let inputNSData = (input as NSString).dataUsingEncoding(NSUTF8StringEncoding);
        let parsed = SWXMLHash.parse(input);
        parsedPackage = package;
        makePackage(parsed["TrackResponse"]["TrackInfo"].element!.attributes["ID"]!);
        addEvents(parsed["TrackResponse"]["TrackInfo"]["TrackSummary"], details: parsed["TrackResponse"]["TrackInfo"]["TrackDetail"] );
        
        // XMLParser = NSXMLParser(data: inputNSData!);
        // XMLParser.delegate = self;
        // XMLParser.parse();
        
        
        return parsedPackage!;
    }
    
    // Take in the tracking number and create the package
    func makePackage(trackingNumber:String){
        parsedPackage!.trackingNumber = trackingNumber;
        parsedPackage!.svcType = NSNumber(int:ServiceType.USPS.rawValue);
    }
    
    // Add the events into the tracking object
    func addEvents(summary:XMLIndexer, details:XMLIndexer){
        var events = NSMutableOrderedSet();
        events.addObject(makeEvent(summary));
        
        for event in details{
            events.addObject(makeEvent(event));
        }
        
        parsedPackage!.events = events;
    }
    
    func makeEvent(event:XMLIndexer) -> TrackingEvent{
        let trackEvent = dm!.makeCDTrackingEvent();
        // EventDate: event["EventDate"].element!.text!, Event: event["Event"].element!.text!
        trackEvent.eventDate = event["EventDate"].element!.text!;
        trackEvent.event = event["Event"].element!.text!;
        
        if(event["EventTime"].element!.text != nil){
            // print(event["EventTime"].element!.text);
            trackEvent.eventTime = event["EventTime"].element!.text
        }else{
            trackEvent.eventTime = "N/A";
        }
        
        if(event["EventCity"].element!.text != nil){
            trackEvent.eventCity = event["EventCity"].element!.text
        }else{
            trackEvent.eventCity = "N/A";
        }
        
        if(event["EventState"].element!.text != nil){
            trackEvent.eventState = event["EventState"].element!.text
        }else{
            trackEvent.eventState = "N/A";
        }
        
        if(event["EventZIPCode"].element!.text != nil){
            trackEvent.eventZip = event["EventZIPCode"].element!.text
        }else{
            trackEvent.eventZip = "N/A";
        }
        
        dm!.saveNewTrackingEvent(trackEvent);
        
        return trackEvent
    }
    
    
}