//
//  LocationPicker.swift
//
//
//  Created by Alessio Rubicini on 13/08/21.
//

import SwiftUI
import MapKit
import UniformTypeIdentifiers

public struct LocationPicker: View {
    
    // MARK: - View properties
    
    @Binding var coordinates: CLLocationCoordinate2D
    var zoomLevel: Double?
    let showCoordinatesOverlay: Bool
    let ignoreSafeArea: Bool
    
    /// Initialize LocationPicker view
    /// - Parameters:
    ///   - coordinates: binding to latitude/longitude coordinates
    ///   - zoomLevel: desired zoom level to initialize map
    ///   - showCoordinatesOverlay: show a floating overlay with current coordinates (tap to copy)
    public init(coordinates: Binding<CLLocationCoordinate2D>,
                zoomLevel: Double? = nil,
                showCoordinatesOverlay: Bool = true,
                ignoreSafeArea: Bool = false) {
        self._coordinates = coordinates
        self.zoomLevel = zoomLevel
        self.showCoordinatesOverlay = showCoordinatesOverlay
        self.ignoreSafeArea = ignoreSafeArea
    }
    
    // MARK: - View body
    
    public var body: some View {
        ZStack(alignment: .top) {
            MapView(centerCoordinate: $coordinates, zoomLevel: zoomLevel)
                .if(ignoreSafeArea) { view in
                    view
                        .edgesIgnoringSafeArea(.vertical)
                }
            

            VStack {
                if showCoordinatesOverlay {
                    if #available(iOS 26, *) {
                        Text("\(coordinates.latitude), \(coordinates.longitude)")
                            .padding()
                            .glassEffect(.regular.interactive())
                            .cornerRadius(50.0)
                            .onTapGesture { self.pasteCoordinates() }
                            .padding()
                    } else {
                        Text("\(coordinates.latitude), \(coordinates.longitude)")
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(50.0)
                            .onTapGesture { self.pasteCoordinates() }
                            .padding()
                    }
                }
                Spacer()
            }
        }
    }
    
    private func pasteCoordinates() {
        UIPasteboard.general.setValue("\(coordinates.latitude), \(coordinates.longitude)", forPasteboardType: UTType.plainText.identifier)
    }

}

#Preview {
    LocationPicker(coordinates: .constant(CLLocationCoordinate2D(latitude: 37.33485149517856, longitude: -122.00903965379115)), zoomLevel: 2000, ignoreSafeArea: true)
}

