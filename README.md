<div align="center">
  <img width="300" height="300" src="/assets/icon.png" alt="Package Logo">
  <h1><b>Location Picker for SwiftUI</b></h1>
  <p>
    LocationPicker for SwiftUI is a Swift package that provides an easy-to-use SwiftUI view for interactive input of geographic coordinates.
    <br>
  </p>
</div>

<div align="center">
  <a href="https://swift.org">
<!--     <img src="https://img.shields.io/badge/Swift-5.9%20%7C%206-orange.svg" alt="Swift Version"> -->
    <img src="https://img.shields.io/badge/Swift-5.7-orange.svg" alt="Swift Version">
  </a>
  <a href="https://www.apple.com/ios/">
    <img src="https://img.shields.io/badge/iOS-14%2B-blue.svg" alt="iOS">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License: MIT">
  </a>
</div>


## Usage

All you need to do is to pass to the `LocationPicker` view a binding to a property of type `CLLocationCoordinate2D` (remember to import the MapKit framework!). This means that once the position is selected, coordinates are directly passed to your previous view through the powerful binding system of SwiftUI without any additional effort. Now put the `LocationPicker` view into a `Sheet` or a `NavigationLink` passing the binding value previously mentioned.

The user is now free to navigate around the map and select the location. Once pressed anywhere on the map, an annotation will appear on the map while coordinates are always displayed in real time at the bottom of the screen. You can also provide a custom text to tell the user what to do.

![Location Picker](./assets/LocationPickerPreview.png)


## Example

Here's a short usage example. You can find the full code in [UsageExample.swift](https://github.com/alessiorubicini/LocationPickerForSwiftUI/blob/master/Sources/LocationPicker/UsageExample.swift)

```swift
import SwiftUI
import MapKit
import LocationPicker

struct Example: View {
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.333747, longitude: -122.011448)
    @State private var showSheet = false

    var body: some View {
        VStack {
            Text("\(coordinates.latitude), \(coordinates.longitude)")
        
            Button("Select location") {
                self.showSheet.toggle()
            }
    }

    .sheet(isPresented: $showSheet) {
        LocationPicker(instructions: "Tap to select coordinates", coordinates: $coordinates, dismissOnSelection: true)
    }
}
```


## Installation

Required:
- iOS 14.0 or above
- Xcode 12.0 or above

In Xcode go to `File -> Add Package Dependencies...` and paste in the repo's url: `https://github.com/alessiorubicini/LocationPickerForSwiftUI`.
Then choose the main branch or the version you desire.


## License

Copyright 2022 (©) Alessio Rubicini.

The license for this repository is MIT License.

Please see the [LICENSE](LICENSE) file for full reference.
