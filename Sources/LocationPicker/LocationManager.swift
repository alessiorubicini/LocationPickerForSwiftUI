import CoreLocation

enum LocationError: Error {
    case authorizationDenied
}

protocol LocationManagerDelegate: AnyObject {
    func onSuccess(location: CLLocation)
    func onLocationError(error: Error)
    func onAuthorizationFailed()
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var currentLocation: CLLocation?
    public let cl_locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    
    // Boolean flag to track if location updates are requested
    private var requestLocationUpdates = false
    
    override init() {
        super.init()
        cl_locationManager.delegate = self
    }
    
    func startUpdatingLocations() {
        let status = CLLocationManager.authorizationStatus()

        switch status {
        case .notDetermined:
            requestLocationUpdates = true
        case .authorizedAlways, .authorizedWhenInUse:
            cl_locationManager.startUpdatingLocation()
        case .denied, .restricted:
            delegate?.onAuthorizationFailed()
        default:
            print("Error when determinining the location authorization")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location // update currentLocation property here
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
                cl_locationManager.startUpdatingLocation()
            }
        } else {
            cl_locationManager.requestWhenInUseAuthorization()
        }
    }
}


