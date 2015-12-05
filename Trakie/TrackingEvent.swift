//
//  TrackingEvent.swift
//  Trakie
//
//  Created by Khoa Nguyen on 12/5/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

class TrackingEvent{
    var EventTime:String?;
    var EventDate:String;
    var Event:String;
    var EventCity:String?;
    var EventState:String?;
    var EventZip:String?;
    
    init(EventDate:String, Event:String){
        self.EventDate = EventDate;
        self.Event = Event;
    }
    
    convenience init(EventTime:String, EventDate:String, Event:String, EventCity:String, EventState:String, EventZip:String){
        self.init(EventDate: EventDate, Event: Event);
        
        self.EventTime = EventTime;
        self.EventCity = EventCity;
        self.EventState = EventState;
        self.EventZip = EventZip;
    }
    
    convenience init(){
        self.init(EventTime:"Unknown", EventDate:"Unknown", Event:"Unknown", EventCity:"Unknown", EventState:"Unknown", EventZip:"Unknown");
    }
    

    
}
