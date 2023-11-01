//
//  LocationManagerDelegate.swift
//
//
//  Created by Alessio Rubicini on 01/11/23.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func onSuccess(location: CLLocation)
    func onLocationError(error: Error)
    func onAuthorizationFailed()
}
