//
//  USPSRetriever.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

class USPSRetriever: Retriever{
    
    func getData(trackingNumber:String) -> String{
        let request = "http://production.shippingapis.com/ShippingAPI.dll?API=TrackV2&XML=%3CTrackFieldRequest%20USERID=%22262PERSO1266%22%3E%3CTrackID%20ID=%22\(trackingNumber)%22%3E%3C/TrackID%3E%3C/TrackFieldRequest%3E";
        let NSRequest = NSURL(string: request);
        var data = NSData(contentsOfURL: NSRequest!);
        var dataString = NSString(data: data!, encoding: NSUTF8StringEncoding);
        
        return dataString as! String;
    }
    
}
