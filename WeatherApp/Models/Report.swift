//
//  Report.swift
//  WeatherApp
//
//  Created by Abhishek K on 24/08/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation

class Report:Codable{
    var cod:String?
    var message:Double?
    var cnt:Double?
    var city:City?
    var list:[List]?
}
