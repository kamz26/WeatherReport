//
//  WeatherApiClient.swift
//  WeatherApp
//
//  Created by Abhishek K on 24/08/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation

class WeatherApiClient:NSObject{
    
    var weatherReport:Report?
    
    func getcityList(completion: @escaping (([City]) -> Void)){
        
        if let path = Bundle.main.path(forResource: "city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let cityList = try JSONDecoder().decode([City].self, from: data)
                completion(cityList)
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    func getWeatherReport(cityCode:Double, completion: @escaping((Report?) -> Void)){
        
        let urlStr = "https://api.openweathermap.org/data/2.5/forecast?id=\(cityCode.cleanValue)&APPID=554fc33eed2b461863eff4461bf63b69"
        
        let url = URL.init(string: urlStr)
        
        let task = URLSession.shared.dataTask(with: url!) {[weak self] (data, response, error) in
            
            guard let strongSelf = self else{return }
            guard let data = data else {return}
            
            do{
                let reportResult = try JSONDecoder().decode(Report.self, from: data)
                strongSelf.weatherReport = reportResult
                completion(reportResult)              
                
            }catch{
                completion(nil)
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
        
    }
    
    
}
