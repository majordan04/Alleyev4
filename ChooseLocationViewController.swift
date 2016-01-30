//
//  ChooseLocationViewController.swift
//  Alleyev4
//
//  Created by Matthew Jordan on 1/24/16.
//  Copyright © 2016 Matthew Jordan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ChooseLocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func setLocation(sender: AnyObject) {
    }
    
    
    //Create location manager property
    let locationManager = CLLocationManager()
    
    var geoCoder: CLGeocoder!
    
    var previousAddress: String!
    
    
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
        
        //Initialize geoCoder
        geoCoder = CLGeocoder ()
        
        self.mapView.delegate = self
        
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
        self.mapView.setRegion(region, animated: false)
        
        //Once the above happens you can stop updating users location
        self.locationManager.stopUpdatingLocation()
        
        geoCode(location)
        
        
    }
    
    
    
    // 3
    //Print out error to the debugger if we have an error with the location Manager
    func locationManger(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let location = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        geoCode(location)
    }
    
    func geoCode(location : CLLocation!){
        /* Only one reverse geocoding can be in progress at a time hence we need to cancel existing
        one if we are getting location updates */
        geoCoder.cancelGeocode()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (data, error) -> Void in
            guard let placeMarks = data as [CLPlacemark]! else {
                return
                
            }
            let loc: CLPlacemark = placeMarks[0]
            let addressDict : [NSString:NSObject] = loc.addressDictionary as! [NSString: NSObject]
            let addrList = addressDict["FormattedAddressLines"] as! [String]
            let address = addrList.joinWithSeparator(", ")
            print(address)
            self.address.text = address
            self.previousAddress = address
        })
        
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var DestViewController : AddEventViewController = segue.destinationViewController as! AddEventViewController
        
        DestViewController.LocationLabeltext = address.text!
        
        
    }

    
    
    
}