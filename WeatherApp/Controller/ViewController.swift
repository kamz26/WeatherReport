//
//  ViewController.swift
//  WeatherApp
//
//  Created by Abhishek K on 24/08/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import UIKit
import MapKit
import CoreData
//  App Key:554fc33eed2b461863eff4461bf63b69
class ViewController: UIViewController {
    
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var changeButton: UIButton!
  @IBOutlet weak var locationButton: UIButton!
  @IBOutlet weak var reportViewModel:WeatherViewModel!
  
  var selectedIndex = -1
  var clLocationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
     
    //  reportViewModel.deleteData()
        
        
        changeButton.setTitle(ButtonTitle.changeLocation.rawValue, for: .normal)
        locationButton.setTitle(ButtonTitle.currentLocation.rawValue, for: .normal)
      
      reportViewModel.loadCities { (cities) in
        print(cities.count)
      }
      
      loadPersistedData()
       
    }
    
    
    
    func setButtonTitle(title:String){
        locationButton.isHidden = false
        locationButton.setTitle(title, for: .normal)
        
    }
  
  
  func loadPersistedData(){
    self.reportViewModel.loadPersistedData(complete: { (bool) in      
      if bool == true{
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    })
  }
    
    @IBAction func locationTapped(_ sender: UIButton) {
        
        self.clLocationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            clLocationManager.delegate = self
            clLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            clLocationManager.startUpdatingLocation()
        }
        
        
        
    }
    @IBAction func changeLocationAction(_ sender: UIButton) {
        
      
            //1. Create the alert controller.
            let alert = UIAlertController(title: "Enter City", message: "", preferredStyle: .alert)
            //2. Add the text field.
            alert.addTextField { (textField) in
                textField.placeholder = "Enter city name."
                
            }            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0]
              
                
                let city = self.reportViewModel.cities.filter({ (city) -> Bool in
                    city.name!.lowercased() == textField!.text!.lowercased()
                })
                
                if city.count > 0{
                   // self.getCityWeatherReport(cityCode: (city?.first?.id!)!)
                   self.reportViewModel.saveToDisK = true
                    self.reportViewModel.weatherReport(cityCode: city.first!.id!, completion: { (city) in
                        
                      guard let city = city else{ return }
                      DispatchQueue.main.async {
                        self.loadPersistedData()
                      }
                        
                    })
                    
                }else{
                    self.cityNotFoundAlert()
                }
               
            }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
            
      
//        }else if sender.titleLabel?.text == ButtonTitle.currentLocation.rawValue{
//
//
//            self.clLocationManager.requestAlwaysAuthorization()
//            self.clLocationManager.startUpdatingLocation()
//            sender.setTitle(ButtonTitle.changeLocation.rawValue, for: .normal)
//
//        }
    }


    func cityNotFoundAlert(){
        let alert = UIAlertController(title: "City is Not Recognized", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
//            let destinamtion = segue.destination as! WeatherDetailViewController
//            destinamtion.weatherViewModel = self.reportViewModel
          let destinamtion = segue.destination as! WeatherDetailViewController
          destinamtion.weatherViewModel = self.reportViewModel
          destinamtion.selectedIndex = self.selectedIndex
          
          
        }
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reportViewModel.reportResultDataList.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = " \(indexPath.row + 1) \(reportViewModel.reportResultDataList[indexPath.row].city!.name!)"
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.selectedIndex = indexPath.row
    performSegue(withIdentifier: "detail", sender: indexPath)
    
  }
  
  
}


extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let _: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        self.clLocationManager.stopUpdatingLocation();
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemark, error) in
            DispatchQueue.main.async {
                
                
            if let placemark = placemark{
                let city = self.reportViewModel.cities.filter({ (city) -> Bool in
                    city.name!.lowercased() == placemark[0].locality!.lowercased()
                })
                
                if city.count > 0{
                    self.reportViewModel.saveToDisK = false
                    self.reportViewModel.weatherReportWithoutPersit(cityCode: (city.first?.id!)!, completion: { (city) in
                        guard let city = city else{return}
                        DispatchQueue.main.async {
                            
                            self.setButtonTitle(title: city.name!)
                            self.performSegue(withIdentifier: "detail", sender: self.reportViewModel.reportResult!)
                            
                        }
                        
                        
                    })
                    
                    
                }else{
                    self.cityNotFoundAlert()
                    
                }
                
            }
            }
        }
    }
    
    
    
    
}






