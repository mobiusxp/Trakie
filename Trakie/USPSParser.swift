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

class USPSParser: NSObject, Parser, NSXMLParserDelegate{
    
    var XMLParser:NSXMLParser;
    
    override init(){
        XMLParser = NSXMLParser();
        super.init();
        XMLParser.delegate = self;
    }
    
    func parse(input:String) -> Package {
        return Package(trackingNumber: "a");
    }
}