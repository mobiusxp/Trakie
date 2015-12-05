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

class USPSParser: Parser{
    
    // var XMLParser:NSXMLParser!;
    var parsedPackage:Package?;
    
    
    func parse(input:String) -> Package {
        // let inputNSData = (input as NSString).dataUsingEncoding(NSUTF8StringEncoding);
        let parsed = SWXMLHash.parse(input);
        makePackage(parsed["TrackResponse"]["TrackInfo"].element!.attributes["ID"]!);
        addEvents(parsed["TrackResponse"]["TrackInfo"]["TrackSummary"], details: parsed["TrackResponse"]["TrackInfo"]["TrackDetail"] );
        
        // XMLParser = NSXMLParser(data: inputNSData!);
        // XMLParser.delegate = self;
        // XMLParser.parse();
        
        
        return parsedPackage!;
    }
    
    // Take in the tracking number and create the package
    func makePackage(trackingNumber:String){
        parsedPackage = Package(trackingNumber: trackingNumber, svcType: ServiceType.USPS);
    }
    
    // Add the events into the tracking object
    func addEvents(summary:XMLIndexer, details:XMLIndexer){
        var events:[TrackingEvent] = [];
        events.append(makeEvent(summary));
        
        for event in details{
            events.append(makeEvent(event));
        }
        
        parsedPackage!.events = events;
    }
    
    func makeEvent(event:XMLIndexer) -> TrackingEvent{
        let trackEvent = TrackingEvent(EventDate: event["EventDate"].element!.text!, Event: event["Event"].element!.text!);
        
        if(event["EventTime"].element!.text != nil){
            trackEvent.EventTime = event["EventTime"].element!.text
        }else{
            trackEvent.EventTime = "N/A";
        }
        
        if(event["EventCity"].element!.text != nil){
            trackEvent.EventCity = event["EventCity"].element!.text
        }else{
            trackEvent.EventCity = "N/A";
        }
        
        if(event["EventState"].element!.text != nil){
            trackEvent.EventState = event["EventState"].element!.text
        }else{
            trackEvent.EventState = "N/A";
        }
        
        if(event["EventZIPCode"].element!.text != nil){
            trackEvent.EventZip = event["EventZIPCode"].element!.text
        }else{
            trackEvent.EventZip = "N/A";
        }
        
        return trackEvent
    }
    
    
}