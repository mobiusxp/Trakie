//
//  ServiceType.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

// Enumerable for Service type so we can add parsers, retrievers, and validators afterwards
enum ServiceType : Int32{
    case Local = 0;
    case USPS = 1;
}