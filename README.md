# LocationPicker for SwiftUI

`LocationPicker for SwiftUI` is a Swift package that provides an easy-to-use SwiftUI view for interactive input of geographic coordinates.

## Usage

All you need to do is to pass to the `LocationPicker` view a binding to a property of type `CLLocationCoordinate2D` (remember to import the MapKit framework!). This means that once the position is selected, coordinates are directly passed to your previous view through the powerful binding system of SwiftUI without any additional effort. Now put the `LocationPicker` view into a `Sheet` or a `NavigationLink` passing the binding value previously mentioned.

The user is now free to navigate around the map and select the location. Once pressed anywhere on the map, an annotation will appear on the map while coordinates are always displayed in real time at the bottom of the screen. You can also provide a custom text to tell the user what to do.

![Location Picker](./Resources/LocationPickerForSwiftUI.png)


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
