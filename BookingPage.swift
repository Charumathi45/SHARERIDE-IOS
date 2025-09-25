import SwiftUI
import CoreLocation

struct RideBookingView: View {
    let request: GetCarListData
    @State private var navigateToVerify = false
    @State private var showAlert = false
    @State private var showMessage: String = ""
    @State private var showSOSAlert = true
    @State private var showShareSheet = false

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.white,
                    Color.purple.opacity(0.9),
                    Color.white,
                    Color.purple.opacity(0.25),
                    Color.white
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        
                        // Ride Info
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(request.pickupLocation) → \(request.dropLocation)")
                                .font(.headline)
                            
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                Text(request.pickupLocation)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                Text(request.dropLocation)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Image(systemName: "clock.fill")
                                Text("\(request.departureDate)")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // Fare Info
                        VStack(alignment: .leading) {
                            Text("₹\(request.seatPrice)")
                                .font(.title)
                                .bold()
                            Text("\(request.availableSeats) seat(s) available")
                                .foregroundColor(.gray)
                        }
                        
                        // Confirm Button
                        Button(action: { bookRide() }) {
                            HStack {
                                Image(systemName: "bolt.fill")
                                Text("Confirm Ride").bold()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        
                        // SOS Button
                        Button(action: { triggerSOS() }) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                Text("SOS Alert").bold()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .alert(isPresented: $showSOSAlert) {
                            Alert(
                                title: Text("SOS Activated!"),
                                message: Text("Emergency services have been notified."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                        
                        // Contact / Share
                        HStack {
                            Spacer()
                            VStack {
                                Button(action: { callDriver() }) {
                                    VStack {
                                        Image(systemName: "phone.fill")
                                        Text("Contact Driver")
                                    }
                                }
                            }
                            Spacer()
                            VStack {
                                Button(action: { showShareSheet = true }) {
                                    VStack {
                                        Image(systemName: "square.and.arrow.up")
                                        Text("Share Ride")
                                    }
                                }
                            }
                            Spacer()
                        }
                        .font(.caption)
                        .padding(.top)
                    }
                    .padding()
                }
                
                NavigationLink(destination: VerifyRideView(request: request), isActive: $navigateToVerify) {
                    EmptyView()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Ride Status"),
                    message: Text(showMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            // Share sheet modifier
            .sheet(isPresented: $showShareSheet) {
                let details = """
                🚗 Ride Details:
                From: \(request.pickupLocation)
                To: \(request.dropLocation)
                Date: \(request.departureDate)
                Fare: ₹\(request.seatPrice)
                """
                ActivityView(activityItems: [details])
            }
        }
    }
    
    // MARK: - Book Ride
    func bookRide() {
        let formData: [String: Any] = [
            "user_id": DataManager.shared.userData?.id ?? 0,
            "from_location": request.pickupLocation,
            "to_location": request.dropLocation,
            "departure_address": "No address",
            "arrival_address": "arrival address",
            "duration": "Min 2 hr Max 7 hr",
            "fare": request.seatPrice,
            "seats_available": request.availableSeats,
            "driver_name": request.driverID,
            "driver_rating": "5",
            "driver_verified": "1",
            "boot_space": "yes",
            "car_model": "Car"
        ]
        
        APIHandler().postAPIValues(
            type: OfferRideResponse.self,
            apiUrl: APIList.booking,
            method: "POST",
            formData: formData
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    showMessage = data.message
                    if data.status == "success" {
                        navigateToVerify = true
                    }
                    showAlert = true
                case .failure:
                    showMessage = "Something went wrong"
                    showAlert = true
                }
            }
        }
    }
    
    // MARK: - SOS Simulation
    func triggerSOS() {
        let fakeLocation = CLLocation(latitude: 13.0827, longitude: 80.2707)
        
        let sosData: [String: Any] = [
            "user_id": DataManager.shared.userData?.id ?? 0,
            "latitude": fakeLocation.coordinate.latitude,
            "longitude": fakeLocation.coordinate.longitude,
            "message": "SOS activated by user"
        ]
        
        print("SOS data sent:", sosData)
        showSOSAlert = true
    }
    
    // MARK: - Call Driver
    func callDriver() {
        let phoneNumber = "9876543210" // Static number
        if let url = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - UIKit Share Sheet Wrapper
struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
