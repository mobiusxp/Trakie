//
//  LocalRetriever.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

class LocalRetriever:Retriever{
    func getData(trackingNumber:String) -> String{
        return "aaa";
    }
    
    // Local retriever can get all data to load saved tracking numbers
    func getAllData() -> String{
        return "aaa";
    }
}