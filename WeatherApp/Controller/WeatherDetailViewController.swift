//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Abhishek K on 24/08/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    var report:Report?
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var country: UILabel!
    var selectedIndex:Int = -1
  
    var weatherViewModel:WeatherViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      if weatherViewModel.listDataViewModelList.count > 0 && selectedIndex != -1{
      city.text = weatherViewModel.reportResultDataList[selectedIndex].city?.name
      country.text = weatherViewModel.reportResultDataList[selectedIndex].city?.country 
      }else{
        city.text = weatherViewModel.reportResult?.city?.name
        country.text =  weatherViewModel.reportResult?.city?.country
        
      }
        // Do any additional setup after loading the view.
    }

   
    
  
    



}

extension WeatherDetailViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if weatherViewModel.listDataViewModelList.count > 0{
            return weatherViewModel.listDataViewModelList[indexPath.row].cellInstanceForLoadedData(collectionView, indexPath)
        }
        return weatherViewModel.listViewModelList[indexPath.row].cellInstance(collectionView,indexPath)
      
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if weatherViewModel.listDataViewModelList.count > 0{
            return weatherViewModel.listDataViewModelList.count
        }
        return weatherViewModel.listViewModelList.count
    }
    
    
    
    
    
   
}
