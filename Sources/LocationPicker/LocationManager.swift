//
//  LocationManager.swift
//
//
//  Created by Alessio Rubicini on 13/08/21.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var currentLocation: CLLocation?
    public let clLocationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    
    // Boolean flag to track if location updates are requested
    private var requestLocationUpdates = false
    
    override init() {
        super.init()
        clLocationManager.delegate = self
    }
    
    func startUpdatingLocations() {
        let authorizationStatus = clLocationManager.authorizationStatus

        switch authorizationStatus {
            case .notDetermined:
                requestLocationUpdates = true
            case .authorizedAlways, .authorizedWhenInUse:
                clLocationManager.startUpdatingLocation()
            case .denied, .restricted:
                delegate?.onAuthorizationFailed()
            default:
                print("Error when determinining the location authorization")
        }
    }
    
    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return clLocationManager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.currentLocation = location
            delegate?.onSuccess(location: location)
            manager.stopUpdatingLocation()
        } else {
            print("No location found in location array")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.onLocationError(error: error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            if requestLocationUpdates {
                clLocationManager.startUpdatingLocation()
            }
        } else {
            clLocationManager.requestWhenInUseAuthorization()
        }
    }
}
