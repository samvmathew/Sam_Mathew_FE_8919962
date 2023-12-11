//
//  WeatherViewController.swift
//  Sam_Mathew_FE_8919962
//
//  Created by Sam Mathew on 2023-12-10.
//

import UIKit

class WeatherViewController: UIViewController {

 let weatherApi = "https://api.openweathermap.org/data/2.5/weather?"
    let weatherApiKey = "173c5d2d2b354722ef79a5ecb76cf4e1"
let getWeatherIconUrl = "https://openweathermap.org/img/wn/"
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var weatherIconImage: UIImageView!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var humidityDisplayLabel: UILabel!
    
    @IBOutlet weak var windDisplayLabel: UILabel!
    
    
    
    var receivedData: String?
    var cityName: String?
    var currentWeather: String?
    var wind: String?
    var humidity: String?
    var temperature: String?
    var _weatherIcon = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Access and use the received data
//                if let name = receivedData{
//                    print("Received data: \(name)")
//                    getWeatherInformation(name)
//                }else {
//                    getWeatherInformation("Waterloo")
//        }
        // Do any additional setup after loading the view.
    }
    
    func setCityName(_ cityName: String) {
        self.cityName = cityName
        getWeatherInformation(cityName)
    }
    
    
    func getWeatherInformation(_ cityName : String){
            
            let weatherApiCall = weatherApi+"q="+cityName+"&appid="+weatherApiKey
            
            print(weatherApiCall)
            
            // Note this shouls be a VAR in when used in an application as the URL value will change with each call!
            // Create an instance of a URLSession Class and assign the value of your URL to the The URL in the Class
            let urlSession = URLSession(configuration:.default)
            let url = URL(string: weatherApiCall)

            // Check for Valid URL
            if let url = url {
                // Create a variable to capture the data from the URL
                let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
                    
                    // If URL is good then get the data and decode
                    if let data = data {
                        print (data)
                        let jsonDecoder = JSONDecoder()
                        do {
                            // Create an variable to store the structure from the decoded stucture
                            let readableData = try jsonDecoder.decode(Weather.self, from: data)
                            
                            //setting values to all variables
                            self.cityName = readableData.name
                            self.currentWeather = readableData.weather[0].description
                            
                            // converting temperature in kelvin to celsius
                            let kelvinTemperature = readableData.main.temp
                            let celsiusTemperature = kelvinTemperature - 273.15
                            self.temperature = "\(String(format: "%.2f", celsiusTemperature))°C"

                            
                            self.humidity = "Humidity: \(Double(readableData.main.humidity))%"
                            self.wind = "Wind Speed: \(Double(readableData.wind.speed))km/h"
                            
                            //getting weather icon
                            let weatherIconUrl = self.getWeatherIconUrl+readableData.weather[0].icon+".png"
                            
                            if let iconURL = URL(string: weatherIconUrl),
                               let imageData = try? Data(contentsOf: iconURL),
                               let weatherIcon = UIImage(data: imageData) {
                               
                                self._weatherIcon = weatherIcon
                                
                            } else {
                                // Handle the case where the image couldn't be loaded
                                print("Error loading weather icon")
                            }
                            
                            //calling function to make display changes
                            self.updateLabels()
                            
                            
                            
                        }
                        //Catch the Broken URL Decode
                        catch {
                            print ("Can't Decode")
                            
                        }
                        
                    }
                    
                }
                dataTask.resume()// Resume the datatask method
                dataTask.response
            }

        }
    
    
    func updateLabels(){
        DispatchQueue.main.async {
            
            self.tempLabel.text = self.temperature
            self.humidityDisplayLabel.text = self.humidity
            self.windDisplayLabel.text = self.wind
            self.cityLabel.text = self.cityName
            self.descriptionLabel.text = self.currentWeather
            self.weatherIconImage.image = self._weatherIcon
            
        }
        
        
    }
    //Icon API
    
    
   
    @IBAction func changeWeatherCity(_ sender: Any) {
    
    
        // Create the alert controller
         let alertController = UIAlertController(title: "Where would you like to go?", message: "Enter your new destination", preferredStyle: .alert)

         // Add a text field to the alert controller
         alertController.addTextField { (newCity) in
             newCity.placeholder = "Enter city name"
         }
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            // Retrieve the city name entered by the user
            if let newCity = alertController.textFields?[0].text {
                self.getWeatherInformation(newCity)
            }
        }
        // Add a cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)

        
    }

}
