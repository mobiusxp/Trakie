//
//  Package.swift
//  Trakie
//
//  Created by Khoa Nguyen on 12/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

class Package{
    var trackingNumber:String;
    var name:String?;
    var notes:String?;
    var status:[(location: String, msg: String)] = [];
    
    init(trackingNumber:String){
        self.trackingNumber = trackingNumber;
    }
    
    convenience init(trackingNumber:String, name:String, notes:String, status:[(location:String,msg:String)]){
        self.init(trackingNumber: trackingNumber);
        self.name = name;
        self.notes = notes;
        self.status = status;
    }
    

    
    
}