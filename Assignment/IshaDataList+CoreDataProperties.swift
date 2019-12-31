//
//  IshaDataList+CoreDataProperties.swift
//  Assignment
//
//  Created by Prakash Sabale on 30/12/19.
//  Copyright © 2019 Orangebit. All rights reserved.
//
//

import Foundation
import CoreData


extension IshaDataList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IshaDataList> {
        return NSFetchRequest<IshaDataList>(entityName: "IshaDataList")
    }

    @NSManaged public var excerpt: String?
    @NSManaged public var title: String?
    @NSManaged public var thumbnail: NSData?

}
