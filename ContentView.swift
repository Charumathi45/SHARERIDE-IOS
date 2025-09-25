import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            if let location = locationManager.userLocation {
                Text("📍 Lat: \(location.coordinate.latitude), Lon: \(location.coordinate.longitude)")
            } else {
                Text("Fetching location…")
            }
        }
        .padding()
    }
}
