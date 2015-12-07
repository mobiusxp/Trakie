//
//  Package.swift
//  Trakie
//
//  Created by Khoa Nguyen on 12/7/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation
import CoreData


class Package: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    func getArray() -> NSArray{
        let events = self.events! as? NSOrderedSet;
        var array:NSMutableArray = [];
        for event in events!{
            array.addObject(event);
        }
        return array;
    }
    
}
