//
//  LocalParser.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

class LocalParser:Parser{
    
    var dm:DataManager?;
    
    func parse(package:Package, input:String) -> Package {
        // return Package(trackingNumber: "a", svcType: ServiceType.Local);
        return Package();
    }
    
}
