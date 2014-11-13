//
//  ViewController.swift
//  Wanderlust
//
//  Created by Ashley M. Loe on 11/10/14.
//  Copyright (c) 2014 Ashley M. Loe. All rights reserved.
//

import UIKit
import MapKit
import AssetsLibrary
import Photos
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //NOTE:
    //The CLLocationManagerDelegate protocol defines the methods used to receive location and heading updates from a CLLocationManager object.
    
    let locationManager = CLLocationManager()
    
    //Have Lat and Long be global.
    //Default is Ford Hall
    var latitude :CLLocationDegrees = 28.4186
    var longitude :CLLocationDegrees = -81.5811
    
    //A structure that defines the area spanned by a map region.
    let span:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
    
    //NOTE:
    //The CLLocationManager class is the central point for configuring the delivery of location- and heading-related events to your app. You use an instance of this class to establish the parameters that determine when location and heading events should be delivered and to start and stop the actual delivery of those events. You can also use a location manager object to retrieve the most recent location and heading data.
    
    @IBOutlet weak var mapView: MKMapView!
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        //NOTE:
        //The CLGeocoder class provides services for converting between a coordinate (specified as a latitude and longitude) and the user-friendly representation of that coordinate.
        longitude = manager.location.coordinate.longitude
        latitude = manager.location.coordinate.latitude
        
        //Structure containing a geographical coordinate
        var curLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        //A structure that defines which portion of the map to display. (center coordinate + span)
        var curRegion:MKCoordinateRegion = MKCoordinateRegionMake(curLocation, span)
        
        self.mapView.setRegion(curRegion, animated: true)
    }
    
    //
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!) {
        self.dismissViewControllerAnimated(true, completion: nil);
        
    }
    
    @IBAction func uploadPic(sender: AnyObject) {
        let pickerC = UIImagePickerController()
        pickerC.delegate = self
        self.presentViewController(pickerC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // A Map kit needs to have certain values
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        
        //new for iOS8. We may add a description as to why we would like to add a user's description
        self.locationManager.startUpdatingLocation()
        
        
        
        //Structure containing a geographical coordinate
        var initialLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        //A structure that defines which portion of the map to display. (center coordinate + span)
        var initialRegion:MKCoordinateRegion = MKCoordinateRegionMake(initialLocation, span)
        
        self.mapView.setRegion(initialRegion, animated: true)
        //NOTE:
        //animated --> Specify YES if you want the map view to animate the transition to the new region or NO if you want the map to center on the specified region immediately
        
        
        // start updating location once the application is loaded
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
