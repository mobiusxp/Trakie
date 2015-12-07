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
    
    //
    func getAllData() -> [String]{
        let packages = NSUserDefaults.standardUserDefaults().arrayForKey("packages") as? [String]
        return packages!;
    }
    
    /*
    func saveFavs(){
        let defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults();
        defaults.setValue(favs, forKey:"favorites");
    }
    */
}