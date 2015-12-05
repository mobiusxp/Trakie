//
//  RetrieverFactory.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

class RetrieverFactory{
    
    func getRetriever(type:ServiceType) -> Retriever{
        switch type{
        case ServiceType.Local:
            return LocalRetriever();
        case ServiceType.USPS:
            return USPSRetriever();
        }
    }
    
}