//
//  UsageExample.swift
//  
//
//  Created by Alessio Rubicini on 13/08/21.
//

import Foundation
import SwiftUI
import MapKit

struct FormExample: View {
    
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.775472967190595, longitude: -122.41735219250484)
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Location")) {
                    Text("This is an example of using LocationPicker inside a Form. Select a location you like.")
                }
                Section(header: Text("Location")) {
                    Text("\(coordinates.latitude), \(coordinates.longitude)")
                    LocationPicker(coordinates: $coordinates, zoomLevel: 90000, showCoordinatesOverlay: false)
                        .frame(height: 400)
                        .cornerRadius(20.0)
                        //.padding(-15) // Optional: to remove form padding
                }
            }.navigationTitle("Form Example")
        }
    }
}

struct ModalSheetExample: View {
    
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.775472967190595, longitude: -122.41735219250484)
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                Text("This is an example of using LocationPicker in a modal sheet.")
                    .multilineTextAlignment(.center)
                
                Text("\(coordinates.latitude), \(coordinates.longitude)")
                
                Button("Select location") {
                    self.showSheet.toggle()
                }
                    
            }
            .navigationTitle("LocationPicker")
            
            .sheet(isPresented: $showSheet) {
                NavigationView {
                    LocationPicker(coordinates: $coordinates, zoomLevel: 100000, showCoordinatesOverlay: false, ignoreSafeArea: true)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    showSheet.toggle()
                                } label: {
                                    Image(systemName: "xmark")
                                }

                            }
                        }
                }
            }
            
        }
    }
}

struct FullScreenExample: View {
    
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.775472967190595, longitude: -122.41735219250484)
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                Text("This is an example of using LocationPicker in full screen mode.")
                    .multilineTextAlignment(.center)
                
                Text("\(coordinates.latitude), \(coordinates.longitude)")
                
                Button("Select location") {
                    self.showSheet.toggle()
                }
                    
            }
            .navigationTitle("LocationPicker")
            
            .fullScreenCover(isPresented: $showSheet) {
                NavigationView {
                    LocationPicker(coordinates: $coordinates, zoomLevel: 100000, showCoordinatesOverlay: false, ignoreSafeArea: true)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    showSheet.toggle()
                                } label: {
                                    Image(systemName: "xmark")
                                }

                            }
                        }
                }
            }
            
        }
    }
}

#Preview("Sheet Example") {
    ModalSheetExample()
}

#Preview("Full Screen Example") {
    FullScreenExample()
}

#Preview("Form Example") {
    FormExample()
}
