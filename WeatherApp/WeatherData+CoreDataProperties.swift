//
//  WeatherData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by user142467 on 8/25/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
        return NSFetchRequest<WeatherData>(entityName: "WeatherData")
    }

    @NSManaged public var id: Double
    @NSManaged public var main: String?
    @NSManaged public var weather: ListData?

}
