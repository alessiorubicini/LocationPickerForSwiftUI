//
//  SwiftUIView.swift
//  
//
//  Created by Alessio Rubicini on 13/08/21.
//

import SwiftUI
import MapKit
import MobileCoreServices

public struct LocationPicker: View {
    
    // MARK: - View properties
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var locationManager = LocationManager()

    let instructions: String
    @Binding var coordinates: CLLocationCoordinate2D
    var zoomLevel: Double?
    @State private var alert = (false, "")
    let dismissOnSelection: Bool
    
    
    /// Initialize LocationPicker view
    /// - Parameters:
    ///   - instructions: label to display on screen
    ///   - coordinates: binding to latitude/longitude coordinates
    ///   - zoomLevel: desired zoom level to initlize map
    public init(instructions: String = "",
                coordinates: Binding<CLLocationCoordinate2D>,
                zoomLevel: Double? = nil,
                dismissOnSelection: Bool = false) {
        self.instructions = instructions
        self._coordinates = coordinates
        self.zoomLevel = zoomLevel
        self.dismissOnSelection = dismissOnSelection
    }
    /// Initialize LocationPicker view
    /// - Parameters:
    ///   - instructions: localized key of the text to display on screen
    ///   - coordinates: binding to latitude/longitude coordinates
    ///   - zoomLevel: desired zoom level to initlize map
    ///   - dismissOnSelection: automatically dismiss the view when new coordinates are selected
    public init(instructions: LocalizedStringKey,
                coordinates: Binding<CLLocationCoordinate2D>,
                zoomLevel: Double? = nil,
                dismissOnSelection: Bool = false) {
        self.instructions = instructions.toString()
        self._coordinates = coordinates
        self.zoomLevel = zoomLevel
        self.dismissOnSelection = dismissOnSelection
    }
    
    // MARK: - View body
    
    public var body: some View {
        ZStack {
            
            MapView(centerCoordinate: $coordinates,
                    zoomLevel: zoomLevel)
                .edgesIgnoringSafeArea(.vertical)
            
            VStack {
                
                if !instructions.isEmpty {
                    Text(self.instructions)
                        .padding()
                        .background(VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
                        .cornerRadius(20))
                        .padding(.top, 10)
                }
                    
                Spacer()
                
            
                Button(action: {
                    let status = CLLocationManager.authorizationStatus()
                    if status == .notDetermined {
                        locationManager.cl_locationManager.requestWhenInUseAuthorization()
                    } else {
                        locationManager.startUpdatingLocations()
                    }
                    if let location = locationManager.currentLocation {
                        coordinates = location.coordinate
                    }
                }) {
                    Image(systemName: "location.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .background(VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial)).cornerRadius(20))
                }
            }.padding()
            
        }
    }
}

struct LocationPicker_Previews: PreviewProvider {
    static var previews: some View {
        LocationPicker(instructions: "Tap to select your coordinates", coordinates: .constant(CLLocationCoordinate2D(latitude: 37.333747, longitude: -122.011448)))
    }
}
