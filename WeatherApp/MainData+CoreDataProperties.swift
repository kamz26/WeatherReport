//
//  MainData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by user142467 on 8/25/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//
//

import Foundation
import CoreData


extension MainData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainData> {
        return NSFetchRequest<MainData>(entityName: "MainData")
    }

    @NSManaged public var humidity: Double
    @NSManaged public var temp: Double
    @NSManaged public var temp_max: Double
    @NSManaged public var temp_min: Double
    @NSManaged public var main: ListData?

}
