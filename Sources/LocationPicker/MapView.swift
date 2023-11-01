//
//  MapView.swift
//  
//
//  Created by Alessio Rubicini on 13/08/21.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var zoomLevel: Double?
    
    let mapView = MKMapView()

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.centerCoordinate = self.centerCoordinate
        
        if let zoomLevel = zoomLevel {
            let region = MKCoordinateRegion(center: self.centerCoordinate, latitudinalMeters: zoomLevel, longitudinalMeters: zoomLevel)
            mapView.setRegion(mapView.regionThatFits(region), animated: true)
        }
       
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        //print(#function)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
        var parent: MapView

        var gRecognizer = UITapGestureRecognizer()

        init(_ parent: MapView) {
            self.parent = parent
            super.init()
            self.gRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
            self.gRecognizer.delegate = self
            self.parent.mapView.addGestureRecognizer(gRecognizer)
        }

        @objc func tapHandler(_ gesture: UITapGestureRecognizer) {
            
            let location = gRecognizer.location(in: self.parent.mapView)
            let coordinate = self.parent.mapView.convert(location, toCoordinateFrom: self.parent.mapView)
            
            // Set the selected coordinates
            let clObject = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            parent.centerCoordinate = clObject
            
            // Place the pin on the map
            let annotation = MKPointAnnotation()
            annotation.coordinate = clObject
            
            withAnimation {
                parent.mapView.removeAnnotations(parent.mapView.annotations)
                parent.mapView.addAnnotation(annotation)
            }
            
        }
    }
}
