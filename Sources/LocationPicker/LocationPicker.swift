//
//  SwiftUIView.swift
//  
//
//  Created by Alessio Rubicini on 13/08/21.
//

import SwiftUI
import MapKit

public struct LocationPicker: View {
    
    // MARK: - View properties
    
    let instructions: String
    @Binding var coordinates: CLLocationCoordinate2D
    
    public init(instructions: String, coordinates: Binding<CLLocationCoordinate2D>) {
        self.instructions = instructions
        self._coordinates = coordinates
    }
    
    
    // MARK: - View body
    
    public var body: some View {
        
        ZStack {
             
            MapView(centerCoordinate: $coordinates)
                .edgesIgnoringSafeArea(.vertical)
            
            VStack {
                
                Text(instructions)
                    .padding().background(VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial)).cornerRadius(20))
                    .padding(.top, 10)
                    
                Spacer()
                
                Text("\(coordinates.latitude), \(coordinates.longitude)")
                    .padding().background(VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial)).cornerRadius(20))
                
            }.padding()
            
        }
        
    }
}

struct LocationPicker_Previews: PreviewProvider {
    static var previews: some View {
        LocationPicker(instructions: "Tap to select your coordinates", coordinates: .constant(CLLocationCoordinate2D(latitude: 37.333747, longitude: -122.011448)))
    }
}

// Blur effect for   SwiftUI 2.0
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
