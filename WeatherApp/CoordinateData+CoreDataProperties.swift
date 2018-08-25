//
//  CoordinateData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by user142467 on 8/25/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//
//

import Foundation
import CoreData


extension CoordinateData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoordinateData> {
        return NSFetchRequest<CoordinateData>(entityName: "CoordinateData")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var coord: CityData?

}
