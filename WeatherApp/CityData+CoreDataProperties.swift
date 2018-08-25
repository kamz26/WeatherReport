//
//  CityData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by user142467 on 8/25/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//
//

import Foundation
import CoreData


extension CityData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityData> {
        return NSFetchRequest<CityData>(entityName: "CityData")
    }

    @NSManaged public var country: String?
    @NSManaged public var id: Double
    @NSManaged public var name: String?
    @NSManaged public var coord: CoordinateData?
    @NSManaged public var relationship: ReportData?

}
