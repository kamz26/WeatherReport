//
//  ListData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by user142467 on 8/25/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//
//

import Foundation
import CoreData


extension ListData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListData> {
        return NSFetchRequest<ListData>(entityName: "ListData")
    }

    @NSManaged public var descriptionText: String?
    @NSManaged public var dt_txt: String?
    @NSManaged public var list: ReportData?
    @NSManaged public var main: MainData?
    @NSManaged public var weather: NSSet?

}

// MARK: Generated accessors for weather
extension ListData {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: WeatherData)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: WeatherData)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}
