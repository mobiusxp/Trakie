//
//  Validator.swift
//  Trakie
//
//  Created by Khoa Nguyen on 12/8/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

class Validator{
    
    func validateTracking(trackingNumber:String, service: ServiceType) -> Bool{
        let pattern = getFormat(service);
        let trackingTest = NSPredicate(format:"SELF MATCHES %@", pattern);
        return trackingTest.evaluateWithObject(trackingNumber);
    }
    
    // Get pattern for tracking numbers if a new service needs to be added
    func getFormat(service: ServiceType) -> String{
        switch service{
        case ServiceType.USPS:
            return "^E\\D{1}\\d{9}\\D{2}$|^9\\d{15,21}$";
        default:
            return "^E\\D{1}\\d{9}\\D{2}$|^9\\d{15,21}$";
        }
    }
    
    
    
}