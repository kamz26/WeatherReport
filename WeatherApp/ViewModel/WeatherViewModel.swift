//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Abhishek K on 24/08/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class WeatherViewModel:NSObject{  
    
    @IBOutlet weak var weatherClient:WeatherApiClient!
    let coreData = CoreDataStack()
    var cities:[City]!
    var reportResult:Report?
    var reportResultDataList = [ReportData]()
    var listDataViewModelList = [ListDataViewModel]()
    var listViewModelList = [ListViewModel]()
    var saveToDisK:Bool = false
    func loadCities(complete: @escaping(([City]) -> Void)){
        weatherClient.getcityList{ cityList in
            self.cities = cityList
            complete(cityList)            
        }
    }
    func  weatherReport( cityCode:Double, completion: @escaping ((City?) -> Void)){
        weatherClient.getWeatherReport(cityCode: cityCode){(report) in
          guard let report = report else {return}
          self.reportResult = report
          let moc = self.coreData.persistentContainer.viewContext
          let reportResult = ReportData(context: moc)
          reportResult.message = report.message?.description
          reportResult.cnt = report.cnt ?? 0
          reportResult.cod = report.cod ?? ""         
          
          for i in 0..<5{
            let listVm = ListViewModel(list: report.list![i])
            let listData = ListData(context: moc)
            listData.descriptionText = listVm.list?.description
            listData.dt_txt = listVm.list?.dt_txt
            
            for weather in (listVm.list?.weather)!{
                let wthr = WeatherData(context: moc)
                wthr.id = weather.id ?? 0
                wthr.main = weather.main ?? ""
                listData.addToWeather(wthr)
                
            }
           let mainData = MainData(context: moc)
            mainData.temp  = listVm.list?.main?.temp ?? 0
            mainData.temp_max = listVm.list?.main?.temp_max ?? 200
            mainData.temp_min = listVm.list?.main?.temp_min ?? -200
            mainData.humidity = listVm.list?.main?.humidity ?? 0
            
            listData.main = mainData
            self.listViewModelList.append(listVm)
            var lisDataVm = ListDataViewModel(list: listData)
            self.listDataViewModelList.append(lisDataVm)
            
            
            
            reportResult.addToList(listData)
          }
          
          
          
          let city = CityData(context: moc)
          city.country = report.city?.country
          city.id = report.city!.id!
          city.name = report.city!.name
          let coordinates = CoordinateData(context: moc)
          coordinates.lat = (report.city?.coord?.lat)!
          coordinates.lon = (report.city?.coord?.lon)!
          city.coord = coordinates
          
          reportResult.city = city
          
          if self.saveToDisK{          
          self.coreData.saveContext()
          }

            completion(report.city)
            
        }
        
    }
  
    func  weatherReportWithoutPersit( cityCode:Double, completion: @escaping ((City?) -> Void)){
        weatherClient.getWeatherReport(cityCode: cityCode){(report) in
            guard let report = report else {return}
            self.reportResult = report
           
            
            for i in 0..<5{
                let listVm = ListViewModel(list: report.list![i])
               
                
                self.listViewModelList.append(listVm)
                
            }
            
            
            
           
            
            completion(report.city)
            
        }
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  func deleteData(){
    
    let moc = self.coreData.persistentContainer.viewContext
    
    
    let request:NSFetchRequest<ReportData> = ReportData.fetchRequest()
    
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: request as! NSFetchRequest<NSFetchRequestResult>)
    
    do{
      try moc.execute(deleteRequest)
    }catch{
      print(error.localizedDescription)
    }
    
  }
  
  
  func loadPersistedData(complete: @escaping (Bool)-> Void){
    
    let moc = self.coreData.persistentContainer.viewContext
    
    
    let request:NSFetchRequest<ReportData> = ReportData.fetchRequest()
    do{
      let reports = try moc.fetch(request)
      print(reports)
      self.reportResultDataList = reports
    for report in reports{
            for listData in report.list!{
            var listVm = ListDataViewModel(list: listData as! ListData)
                self.listDataViewModelList.append(listVm)
            }
        }
        
        
      complete(true)
    }catch{
      complete(false)
      print("Failed!!")
    }
    
    
    
    
  }
  
  
  
    
    
}
