//
//  UsageExample.swift
//  
//
//  Created by Alessio Rubicini on 13/08/21.
//

import Foundation
import SwiftUI
import MapKit

struct UsageExample: View {
    
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.333747, longitude: -122.011448)
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("\(coordinates.latitude), \(coordinates.longitude)")
                
                Button("Select location") {
                    self.showSheet.toggle()
                }
                    
            }
            .navigationTitle("LocationPicker")
            
            .sheet(isPresented: $showSheet) {
                LocationPicker(instructions: "Tap to select coordinates", coordinates: $coordinates, dismissOnSelection: true)
            }
            
        }
    }
}

struct UsageExample_Previews: PreviewProvider {
    static var previews: some View {
        UsageExample()
    }
}
