//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Abhishek K on 24/08/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var weatherMain: UILabel!    
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var temp: UILabel!    
    
    func setUp(vm:ListViewModel){
        temp.text = vm.tempText
        weatherMain.text = vm.weatherMainText
        dateTime.text = vm.dateTimeText       
        
    }
    func setUpData(vm:ListDataViewModel){
        temp.text = vm.tempDataText
        weatherMain.text = vm.weatherMainTextData
        dateTime.text = vm.dateTimeTextData
    }
}
