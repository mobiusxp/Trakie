//
//  TrackingEvent+CoreDataProperties.swift
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

extension TrackingEvent {

    @NSManaged var event: String?
    @NSManaged var eventCity: String?
    @NSManaged var eventDate: String?
    @NSManaged var eventState: String?
    @NSManaged var eventTime: String?
    @NSManaged var eventZip: String?
    @NSManaged var package: Package?

}
