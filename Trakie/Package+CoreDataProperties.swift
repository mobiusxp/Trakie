//
//  Package+CoreDataProperties.swift
//  Trakie
//
//  Created by Khoa Nguyen on 12/7/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Package {

    @NSManaged var name: String?
    @NSManaged var notes: String?
    @NSManaged var svcType: NSNumber?
    @NSManaged var trackingNumber: String?
    @NSManaged var events: NSOrderedSet?

}
