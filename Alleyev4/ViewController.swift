//
//  ViewController.swift
//  Alleyev4
//
//  Created by Matthew Jordan on 1/3/16.
//  Copyright © 2016 Matthew Jordan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    //Connects MapView to View Controller
    @IBOutlet weak var mapView: MKMapView!
    
   //Create location manager property
    let locationManager = CLLocationManager()
    
    //Cancels AddEventViewController nd returns user to Main Storyboard
    @IBAction func cancelToViewController(segue:UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
   
    // 1
        //Corfirms it to the delegate method
        self.locationManager.delegate = self
        
        //Want the users exact location
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
   
        //Only want to be using location services when using the app. important for battery
        self.locationManager.requestWhenInUseAuthorization ()
   
        //turn on location manager to start looking for user's location
        self.locationManager.startUpdatingLocation ()
        
        //Shows dot on mapView
        self.mapView.showsUserLocation = true
   // 1
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
   // 2
        //Location Delegate methods
        func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
            //Will continually call CLLocationManager until we tell it to stop
            let location = locations.last
            
            // Center current location on the map
            let center = CLLocationCoordinate2D (latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
            
            //Creating a circular region that we want the map to zoom to
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            
            //Set mapView to that region
            //set animation to true so you get zooming effect
            self.mapView.setRegion(region, animated: true)
            
            //Once the above happens you can stop updating users location
            self.locationManager.stopUpdatingLocation()
        }
    

    // 3
        //Print out error to the debugger if we have an error with the location Manager
    func locationManger(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
   
   
    
    
}

