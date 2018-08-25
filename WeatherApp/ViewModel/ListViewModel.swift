//
//  ListViewModel.swift
//  WeatherApp
//
//  Created by Abhishek K on 24/08/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation
import UIKit


protocol CellRepresent {
    
    func cellInstance(_ collectionView:UICollectionView, _ indexPath:IndexPath) -> UICollectionViewCell
    
    
    
}
class ListViewModel:NSObject,CellRepresent{
    
    var list:List?
    
    
    var tempText:String{
        return "\(String(describing: list!.main!.temp!.cleanValue)) F"
    }
    var weatherMainText:String{
        return (list?.weather?.first?.main!)!
    }
    var dateTimeText:String{
        return (list?.dt_txt!)!
    }
    
    func cellInstance(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
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
        cell.setUp(vm:self)
        return cell
    }
    
      
    
}

extension ListViewModel{
    convenience init(list:List){
        self.init()
        self.list = list
    }
}
