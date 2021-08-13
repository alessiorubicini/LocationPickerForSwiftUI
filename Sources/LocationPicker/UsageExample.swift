//
//  File.swift
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
            Form {
                
                Section(header: Text("Info")) {
                    Text("Developed by Alessio Rubicini")
                }
                
                Section(header: Text("Location")) {
                    Text("\(coordinates.latitude), \(coordinates.longitude)")
                    Button("Select location") {
                        self.showSheet.toggle()
                    }
                }
                    
            }
            .navigationTitle("LocationPicker")
            
            .sheet(isPresented: $showSheet) {
                NavigationView {
                    
                    // Just put the view into a sheet or navigation link
                    LocationPicker(instructions: "Tap somewhere to select your coordinates", coordinates: $coordinates)
                        
                    // You can assign it some NavigationView modifiers
                        .navigationTitle("Location Picker")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(leading: Button(action: {
                            self.showSheet.toggle()
                        }, label: {
                            Text("Close").foregroundColor(.red)
                        }))
                }
            }
            
        }
    }
}

struct UsageExample_Previews: PreviewProvider {
    static var previews: some View {
        UsageExample()
    }
}
