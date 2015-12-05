//
//  Validator.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

protocol Validator{
    
    func validate(trackingNumber:String) -> Bool; 
    
}