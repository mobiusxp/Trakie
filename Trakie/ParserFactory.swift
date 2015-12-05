//
//  ParserFactory.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

class ParserFactory{
    
    func getParser(type:ServiceType) -> Parser{
        switch type{
        case ServiceType.Local:
            return LocalParser();
        case ServiceType.USPS:
            return USPSParser();
        }
    }
}