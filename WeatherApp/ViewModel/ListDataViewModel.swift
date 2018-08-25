//
//  ListDataViewModel.swift
//  WeatherApp
//
//  Created by user142467 on 8/25/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation
import UIKit

protocol CellRepresentData {
    
       
    func cellInstanceForLoadedData(_ collectionView:UICollectionView, _ indexPath:IndexPath) -> UICollectionViewCell
    
}
class ListDataViewModel{
    //delelte
    var listData:ListData? 
    
    var tempDataText:String{
        return "\(String(describing:listData!.main!.temp.cleanValue)) F"
    }
    
    var weatherMainTextData:String{
        for wthr in (listData?.weather)!{
            return ((wthr as! WeatherData).main)!
        }
        return ""
    }
    var dateTimeTextData:String{
        return (listData?.dt_txt)!
        
    }
    
    
    func cellInstanceForLoadedData(_ collectionView:UICollectionView, _ indexPath:IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! WeatherCollectionViewCell
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 3.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        
        
        cell.backgroundColor = UIColor.lightGray
        cell.setUpData(vm:self)
        return cell
        
        
        
    }

    
    
    
}

extension ListDataViewModel{
    convenience init(list:ListData){
        self.init()
        self.listData = list
    }
}


