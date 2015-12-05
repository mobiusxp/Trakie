//
//  Package.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

class Package{
    let trackingNumber:String;
    var name:String;
    var notes:String?;
    var events:[TrackingEvent]?;
    let svcType:ServiceType;
    
    init(trackingNumber:String, svcType:ServiceType){
        self.trackingNumber = trackingNumber;
        self.name = trackingNumber;
        self.svcType = svcType;
    }
    
    convenience init(svcType:ServiceType, trackingNumber:String, name:String, notes:String, events:[TrackingEvent]){
        self.init(trackingNumber: trackingNumber, svcType: svcType);
        self.name = name;
        self.notes = notes;
        self.events = events;
    }
    

    
    
}