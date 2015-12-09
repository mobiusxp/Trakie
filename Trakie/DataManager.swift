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
import UIKit
import CoreData

class DataManager{
    
    //
    func getData(input:Package, source:ServiceType) throws -> Package?{
        let retriever = RetrieverFactory().getRetriever(source);
        
        
        
        do{
            let toParse = try retriever.getData(input.trackingNumber!);
            var parser = ParserFactory().getParser(source);
            parser.dm = self;
            let parsed = try parser.parse(input, input: toParse);
            return parsed;
            
        }catch TrakieError.RetrieverError{
            print("Retriever cat.jpg");
        }catch TrakieError.ParserError{
            throw TrakieError.ParserError;
            print("Parser cat.jpg");
        }
        catch{
            print("Error cat.jpg");
            // return nil;
        }

        
        return nil;
    }
    
    
    // Load the user's saved packages
    func loadUserList() -> [Package]{
        return [];
    }
    
    

    
    // Load saved data
    func loadSaveData() -> [Package]{
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext

        let fetchRequest = NSFetchRequest(entityName: "Package")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            let packages = results as! [Package]
            return packages;
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return [];
        }
        
    }
    
    func saveNewPackage(trackingNumber:String, name:String, notes:String?, svcType:ServiceType) throws{
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Package",
            inManagedObjectContext:managedContext)
        
        let package = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        package.setValue(name, forKey: "name")
        package.setValue(trackingNumber, forKey: "trackingNumber");
        package.setValue(NSInteger(svcType.rawValue), forKey: "svcType");
        var loadedPackage:Package?;
        do{
            loadedPackage = try getData(package as! Package, source: ServiceType.USPS);
        }catch TrakieError.ParserError{
            // print("error caught");
            throw TrakieError.ParserError;
        }catch let vague as ErrorType{
            print("I write bad code \(vague)");
        }
        
        do{
            try managedContext.save()
            //5
            appDelegate.packages!.append(loadedPackage!);
        }catch let error as NSError{
            print("I write bad code \(error)");
        }

    }
    
    func saveNewTrackingEvent(toStore:TrackingEvent){
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        // toStore.setValue(event.event, forKey: "event")
        // toStore.setValue(event.eventDate, forKey: "eventDate");
        // toStore.setValue(event.eventTime, forKey: "eventTime");
        // let loadedPackage = getData(package as! Package, source: ServiceType.USPS);
        
        //4
        do {
            try managedContext.save()
            //5
            // appDelegate.packages!.append(loadedPackage!);
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func makeCDTrackingEvent() -> TrackingEvent{
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("TrackingEvent",
            inManagedObjectContext:managedContext)
        
        let toStore = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        return toStore as! TrackingEvent;
    }
    
    // Delete a Package from CoreData
    func deleteCDPackage(packageid : Int){
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext;
        managedContext.deleteObject(appDelegate.packages![packageid] as NSManagedObject);
        appDelegate.packages!.removeAtIndex(packageid);
        appDelegate.saveContext();
    }
    
    /*
    func testUSPS() -> Package{
        let test = USPSRetriever();
        let testParse = USPSParser();
        do{
          let lol = try test.getData("9374889949010715350525");
            let testPkg = testParse.parse(lol);
            return testPkg;
            
        }catch TrakieError.ParserError{
            print("error cat.jpg");
        }catch{
            print("error 2");
        }
        
        // return Package(trackingNumber: "lol", svcType: ServiceType.Local);
        return Package();
    }
    */
    
}