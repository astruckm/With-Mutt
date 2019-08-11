//
//  LocationManager.swift
//  With Mutt
//
//  Created by ASM on 7/11/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import UIKit
import CoreLocation

class WithMuttLocationService: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func startReceivingLocationChanges() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        guard authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways else {
            // User has not authorized access to location information.
            return
        }
        // Do not start services that aren't available.
        guard CLLocationManager.locationServicesEnabled() else {
            // Location services is not available.
            return
        }
        // Configure and start the service.
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100.0  // In meters.
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.delegate = self
        enableBasicLocationServices()
    }
    
    private func enableBasicLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            // Disable location features
            locationManager.stopUpdatingLocation()
            break
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            locationManager.startUpdatingLocation() /// more intensive CL service, consider significant change one
            break
        @unknown default:
            fatalError("new location authorization status selected")
        }
    }

    
    func stopUpatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations: \(locations)")
        guard let mostRecentLocation = locations.last else { return }
        guard abs(mostRecentLocation.timestamp.timeIntervalSinceNow) < (60 * 60) else {
            return
        }
        currentLocation = mostRecentLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError {
            switch error.code {
            case .denied: ///when the user denies authorization for location services
                manager.stopUpdatingLocation()
            case .network:
                print("Location services experiencing network error")
                //Possibly can present alert to user if they are expecting location update
            default: break
            }
        }
        
        //TODO: notify the user of error/reason
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            break
        case .notDetermined:
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorizedWhenInUse:
            startReceivingLocationChanges()
        @unknown default:
            break
        }
    }
}
