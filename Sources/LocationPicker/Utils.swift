//
//  Utils.swift
//  LocationPicker
//
//  Created by Alessio Rubicini on 17/09/25.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

