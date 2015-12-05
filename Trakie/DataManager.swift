//
//  DataManager.swift
//  Trakie
//
//  Data manager uses the established service types and the associated protocols
//  to pull data, parse it and return packages to the app. Because it takes service types
//  we can add new services in later without too much(?) difficulty.
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

class DataManager{
    
    func getData(input:String, source:ServiceType) -> Package?{
        
        return nil;
    }
    
    func getAllData(source:ServiceType)->[Package]{
        
        return [];
    }
    
    
}