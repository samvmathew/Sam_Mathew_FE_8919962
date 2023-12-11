//
//  HomeController.swift
//  Sam_Mathew_FE_8919962
//
//  Created by Sam Mathew on 2023-12-10.
//

import UIKit
import MapKit

class HomeController: UIViewController, CLLocationManagerDelegate {

   
    @IBOutlet weak var currentLocation: MKMapView!
    
    

    // Create a CLLocationManager to manage location updates
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the CLLocationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // Show the user's current location on the map
        currentLocation.showsUserLocation = true
    }

    

       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let userLocation = locations.last?.coordinate else {
               return
           }

           
           let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
           currentLocation.setRegion(region, animated: true)

           // Optionally, you can add a pin to mark the user's location
           let annotation = MKPointAnnotation()
           annotation.coordinate = userLocation
           annotation.title = "Current Location"
           currentLocation.addAnnotation(annotation)

           // Stop updating location to conserve battery
           locationManager.stopUpdatingLocation()
       }

    @IBAction func discoverButton(_ sender: Any) {
    
        // Create an alert controller with a text field
        let alertController = UIAlertController(title: "Enter City Name", message: nil, preferredStyle: .alert)

        // Add a text field to the alert controller
        alertController.addTextField { (textField) in
            textField.placeholder = "City Name"
        }

        // Add actions (options) to the alert controller
        let option1Action = UIAlertAction(title: "News", style: .default) { [weak self] (_) in
            // Retrieve the entered city name from the text field
            if let cityName = alertController.textFields?.first?.text {
                // Set the tab bar controller's selected index to navigate to the first screen with the city name
                self?.navigateToScreen(index: 1, cityName: cityName)
            }
        }

        let option2Action = UIAlertAction(title: "Direction", style: .default) { [weak self] (_) in
            // Retrieve the entered city name from the text field
            if let cityName = alertController.textFields?.first?.text {
                // Set the tab bar controller's selected index to navigate to the second screen with the city name
                self?.navigateToScreen(index: 2, cityName: cityName)
            }
        }

        let option3Action = UIAlertAction(title: "Weather", style: .default) { [weak self] (_) in
            // Retrieve the entered city name from the text field
            if let cityName = alertController.textFields?.first?.text {
                // Set the tab bar controller's selected index to navigate to the third screen with the city name
                self?.navigateToScreen(index: 3, cityName: cityName)
            }
        }

        // Add the actions to the alert controller
        alertController.addAction(option1Action)
        alertController.addAction(option2Action)
        alertController.addAction(option3Action)

        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }

    // Function to set the tab bar controller's selected index and pass the city name to the destination screen
    
    func navigateToScreen(index: Int, cityName: String) {
        if let tabBarController = self.tabBarController,
           let viewControllers = tabBarController.viewControllers,
           index < viewControllers.count {
            // Set the tab bar controller's selected index
            tabBarController.selectedIndex = index

            // Get the navigation controller for the selected tab
            if let navController = tabBarController.viewControllers?[index] as? UINavigationController {
                // Check if the top view controller is NewsTableViewController
                if let topViewController = navController.topViewController as? NewsTableViewController {
                    topViewController.setCityName(cityName)
                }
            } else if let destinationVC = viewControllers[index] as? MapViewController {
                destinationVC.setCityName(cityName)
            } else if let destinationVC = viewControllers[index] as? WeatherViewController {
                destinationVC.setCityName(cityName)
            }
        }
    }
}
