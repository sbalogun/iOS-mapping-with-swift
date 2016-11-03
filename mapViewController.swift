//
//  mapViewController.swift
//  projectNYiT
//
//  Created by Soji Balogun on 10/31/16.
//  Copyright © 2016 Soji Balogun. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager:CLLocationManager=CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Create a location
        let location = CLLocationCoordinate2D(latitude: 40.769693, longitude: -73.982586)
        
        // Create a span
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        
        // Create a region
        let region = MKCoordinateRegion(center: location, span: span)
        
        // Set a region for the map
        self.mapView.setRegion(region, animated: true)
        
        // Add a pin
        
        let pin = MKPointAnnotation()
        pin.coordinate = location
        pin.title = "User"
        pin.subtitle = "location"
        self.mapView.addAnnotation(pin)
        
        // Set self as the delegate for the location manager
        self.locationManager.delegate = self
        
        // Start updating location
        //self.locationManager.startUpdatingLocation()
        
        // Check if this app have permission to use location services
        let authorizationStatus:CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus == CLAuthorizationStatus.denied {
            // TODO: Tell user that phone functionality is limited
        }
            
        else if authorizationStatus == CLAuthorizationStatus.notDetermined
        {
            // Manually prompt the user for permission
            self.locationManager.requestWhenInUseAuthorization()
            
        }
            
        else if authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse
        {
            self.locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        NSLog("found")
        
        if locations.count > 0
        {
            self.locationManager.startUpdatingLocation()
            
            // Update the map with the location
            
            // Get the coordinates
            let location = locations [0] as CLLocation
            
            // Get the span
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            
            // Set up the region
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            
            // Set up the region for the mapView
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        NSLog("error in loating")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == CLAuthorizationStatus.denied
        {
            // TODO: Tell user that some functionality may be disable
            
        }
            
        else if status == CLAuthorizationStatus.authorizedWhenInUse
        {
            // Use location services
            self.locationManager.startUpdatingLocation()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
