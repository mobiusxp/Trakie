//
//  USPSRetriever.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

class USPSRetriever: Retriever{
    
    func getData(trackingNumber:String) throws -> String{
        let request = "http://production.shippingapis.com/ShippingAPI.dll?API=TrackV2&XML=%3CTrackFieldRequest%20USERID=%22262PERSO1266%22%3E%3CTrackID%20ID=%22\(trackingNumber)%22%3E%3C/TrackID%3E%3C/TrackFieldRequest%3E";

            let NSRequest = NSURL(string: request);
            let data = NSData(contentsOfURL: NSRequest!);

            if(data != nil){
                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding);
                if(dataString != nil){
                    return dataString as! String;
                }else{
                    throw TrakieError.ParserError;
                }
            }else{
                throw TrakieError.ParserError;
            }

        
    }

    
}
