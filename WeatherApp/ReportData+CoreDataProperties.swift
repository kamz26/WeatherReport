//
//  ReportData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by user142467 on 8/25/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//
//

import Foundation
import CoreData


extension ReportData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReportData> {
        return NSFetchRequest<ReportData>(entityName: "ReportData")
    }

    @NSManaged public var cnt: Double
    @NSManaged public var cod: String?
    @NSManaged public var message: String?
    @NSManaged public var city: CityData?
    @NSManaged public var list: NSSet?

}

// MARK: Generated accessors for list
extension ReportData {

    @objc(addListObject:)
    @NSManaged public func addToList(_ value: ListData)

    @objc(removeListObject:)
    @NSManaged public func removeFromList(_ value: ListData)

    @objc(addList:)
    @NSManaged public func addToList(_ values: NSSet)

    @objc(removeList:)
    @NSManaged public func removeFromList(_ values: NSSet)

}
