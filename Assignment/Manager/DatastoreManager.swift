//
//  DatastoreManager.swift
//  Assignment
//
//  Created by Prakash Sabale on 30/12/19.
//  Copyright © 2019 Orangebit. All rights reserved.
//

import Foundation
import CoreData

class DatastoreManager {
    
    public static var shared: DatastoreManager! = nil
    
    var managedContext: NSManagedObjectContext
    
    private init(context: NSManagedObjectContext) {
        self.managedContext = context
    }
    
    public class func shared(context: NSManagedObjectContext) {
        if (self.shared == nil) {
            self.shared = DatastoreManager(context: context)
            self.shared.managedContext = context
        }
    }
    
    public func save(title: String, excerpt: String, thumbNail : NSData) {
        // Create Entity
        let entity = NSEntityDescription.entity(forEntityName: "IshaDataList", in: managedContext)
        
        // Initialize Record
        let record = IshaDataList(entity: entity!, insertInto: managedContext)
        record.title = title
        record.excerpt = excerpt
        record.thumbnail = thumbNail
        
        managedContext.performAndWait {
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("could not save, managedobject \(error), \(error.userInfo)")
            }
        }
    }
    
    public func fetchAllSavedOptions() -> [IshaDataList] {
        let request: NSFetchRequest<IshaDataList> = IshaDataList.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            for data in result {
            }
            return result
        } catch {
            print("fetch request failed, managedobject")
            return [IshaDataList]()
        }
    }
    
    public func deleteAllSavedData() {
        let savedItems = fetchAllSavedOptions()
        for savedItem in savedItems {
            managedContext.performAndWait {
                managedContext.delete(savedItem)
            }
        }
    }
    
}
