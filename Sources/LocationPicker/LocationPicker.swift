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
    
    let instructions: String
    @Binding var coordinates: CLLocationCoordinate2D
    @State private var alert = (false, "")
    let dismissOnSelection: Bool
    let safeAreaEdges: Edge.Set
    
    /// Initialize LocationPicker view
    /// - Parameters:
    ///   - instructions: label to display on screen
    ///   - coordinates: binding to latitude/longitude coordinates
    public init(instructions: String = "", coordinates: Binding<CLLocationCoordinate2D>, dismissOnSelection: Bool = false, safeAreaEdges: Edge.Set = .vertical) {
        self.instructions = instructions
        self._coordinates = coordinates
        self.dismissOnSelection = dismissOnSelection
        self.safeAreaEdges = safeAreaEdges
    }
    /// Initialize LocationPicker view
    /// - Parameters:
    ///   - instructions: localized key of the text to display on screen
    ///   - coordinates: binding to latitude/longitude coordinates
    ///   - dismissOnSelection: automatically dismiss the view when new coordinates are selected
    public init(instructions: LocalizedStringKey, coordinates: Binding<CLLocationCoordinate2D>, dismissOnSelection: Bool = false, safeAreaEdges: Edge.Set = .vertical) {
        self.instructions = instructions.toString()
        self._coordinates = coordinates
        self.dismissOnSelection = dismissOnSelection
        self.safeAreaEdges = safeAreaEdges
    }
    
    // MARK: - View body
    
    public var body: some View {
        ZStack {
            
            MapView(centerCoordinate: $coordinates)
                .edgesIgnoringSafeArea(safeAreaEdges)
            
            VStack {
                
                if !instructions.isEmpty {
                    Text(self.instructions)
                        .padding()
                        .background(VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
                        .cornerRadius(20))
                        .padding(.top, 10)
                }
                    
                Spacer()
                
                Text("\(coordinates.latitude), \(coordinates.longitude)")
                    .padding()
                    .background(VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial)).cornerRadius(20))
                    .onTapGesture {
                        UIPasteboard.general.setValue("\(coordinates.latitude), \(coordinates.longitude)", forPasteboardType: kUTTypePlainText as String)
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
