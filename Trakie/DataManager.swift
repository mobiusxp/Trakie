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
    
    //
    func getData(input:String, source:ServiceType) -> Package?{
        let retriever = RetrieverFactory().getRetriever(source);
        /*
        do{
            try retriever.getData(input);
        }catch TrakieError.RetrieverError{
            print("Error cat.jpg");
        }
        */
        
        return nil;
    }
    
    // Load the user's saved packages
    func loadUserList() -> [Package]{
        return [];
    }
    
    
    func testUSPS() -> Package{
        let test = USPSRetriever();
        let testParse = USPSParser();
        do{
          let lol = try test.getData("9374889949010715350525");
            var testPkg = testParse.parse(lol);
            return testPkg;
            
        }catch TrakieError.ParserError{
            print("error cat.jpg");
        }catch{
            print("error 2");
        }
        
        return Package(trackingNumber: "lol", svcType: ServiceType.Local);
    }
    
}