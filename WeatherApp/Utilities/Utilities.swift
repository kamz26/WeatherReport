//
//  Utilities.swift
//  WeatherApp
//
//  Created by Abhishek K on 23/08/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation
import UIKit



enum ButtonTitle:String{
    case currentLocation = "Current City"
    case changeLocation = "Input city"
}



extension  UIView{
    
    @IBInspectable var cornerRadius:CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

extension Double{
    
    var cleanValue:String{
        return String(format: "%.0f",self)
    }
}
