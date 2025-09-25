import SwiftUI
import CoreLocation

struct ConfirmBooking: View {
    @Environment(\.dismiss) var dismiss
    @State private var bookings: [Booking] = []
    @State private var errorMessage: String?
    @State private var navigateToOngoingRide = false
    @State private var showSOSAlert = false
       
    var body: some View {
        NavigationStack {
            ZStack {
                // 🌈 Updated Gradient (smooth purple + white blend)
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
                    // Back button
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                            Text("Back")
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("My bookings")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundColor(.purple)
                        
                        HStack {
                            Text("\(bookings.first?.fromLocation ?? "") → \(bookings.first?.toLocation ?? "")")
                                .font(.headline)
                            Spacer()
                            if let fare = bookings.first?.fare, !fare.isEmpty {
                                Text("₹\(fare)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.purple)
                            }
                        }
                        
                        if let duration = bookings.first?.duration, !duration.isEmpty {
                            Text("Duration: \(duration)")
                                .font(.subheadline)
                        }
                        
                        Text("Seats Available: \(bookings.first?.seatsAvailable ?? 0)")
                        Text("Driver: \(bookings.first?.driverName ?? "")")
                        
                        if let bookingTime = bookings.first?.bookingTime {
                            if isBookingExpired(bookingTime) {
                                Text("Current ride")
                                    .font(.footnote)
                                    .foregroundColor(.red)
                            } else {
                                Text("Yet to Start")
                                    .font(.footnote)
                                    .foregroundColor(.green)
                            }
                        }
                        
                        Text("Booked on \(formattedDate(bookings.first?.bookingTime ?? ""))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                        // Start Ride Button
                        Button(action: {
                            navigateToOngoingRide = true
                        }) {
                            Text("Start Ride")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.top, 20)
                        
                        // SOS Button
                        Button(action: {
                            triggerSOS()
                        }) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                Text("SOS Alert").bold()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                        .padding(.top, 10)
                        .alert(isPresented: $showSOSAlert) {
                            Alert(
                                title: Text("SOS Activated!"),
                                message: Text("Emergency services have been notified."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .gray.opacity(0.1), radius: 6, x: 0, y: 3)
                    
                    Spacer()
                }
                .onAppear {
                    fetchBookings()
                }
                .navigationDestination(isPresented: $navigateToOngoingRide) {
                    if let booking = bookings.first {
                        OngoingRideScreen(booking: booking)
                    }
                }
            }
        }
    }
    
    // MARK: - SOS Function
    func triggerSOS() {
        guard let booking = bookings.first else {
            return
        }
        
        let fakeLocation = CLLocation(latitude: 13.0827, longitude: 80.2707)
        
        let sosData: [String: Any] = [
            "user_id": DataManager.shared.userData?.id ?? 0,
            "latitude": fakeLocation.coordinate.latitude,
            "longitude": fakeLocation.coordinate.longitude,
            "message": "SOS activated for ride from \(booking.fromLocation) to \(booking.toLocation)"
        ]
        
        print("SOS data sent:", sosData) // simulate backend call
        showSOSAlert = true
    }
    
    func isBookingExpired(_ bookingTime: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = formatter.date(from: bookingTime) {
            return date < Date()
        }
        return false
    }
    
    private func formattedDate(_ dateStr: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = formatter.date(from: dateStr) {
            formatter.dateFormat = "MMM d, yyyy h:mm a"
            return formatter.string(from: date)
        }
        return dateStr
    }
    
    private func fetchBookings() {
        let driverName = DataManager.shared.userData?.id ?? ""
        let url = APIList.confirmbooking + "?driver_name=\(driverName)"
        
        APIHandler().getAPIValues(type: confirmbookingresponse.self, apiUrl: url, method: "GET") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if data.status == "success" {
                        bookings = data.bookings
                    } else {
                        errorMessage = "No bookings found."
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}

import SwiftUI

// MARK: - Ongoing Ride Screen
// MARK: - Ongoing Ride Screen
struct OngoingRideScreen: View {
    var booking: Booking
    @State private var rideCompleted = false
    @State private var rideStartTime = Date()
    @State private var elapsedTime: TimeInterval = 0
    @State private var rideProgress: CGFloat = 0.0
    @State private var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            // 🌍 Cartoon Map Background
            Image("cartoon_map") // <- Add your cartoon map image in Assets
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 1.5) // light blur for focus on content
                .opacity(0.85)    // make background soft
            
            // Gradient overlay for readability
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.white.opacity(0.2),
                    Color.purple.opacity(0.1),
                    Color.white.opacity(0.2)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                // 🚗 Animated car
                GeometryReader { geo in
                    HStack {
                        Text("🚗")
                            .font(.system(size: 40))
                            .offset(x: rideProgress * (geo.size.width - 60)) // car moves
                        Spacer()
                    }
                }
                .frame(height: 50)
                
                // 📋 Ride Info Card
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ride in Progress")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.purple)
                    
                    Text("From: \(booking.fromLocation)")
                    Text("To: \(booking.toLocation)")
                    Text("Driver: \(booking.driverName)")
                    
                    if !(booking.fare.isEmpty ?? true) {
                        Text("Fare: ₹\(booking.fare)")
                    }
                    
                    Text("Seats: \(booking.seatsAvailable)")
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(12)
                .shadow(radius: 4)
                
                // 🕒 Timer Display
                VStack {
                    Text("Elapsed Time")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(formatElapsedTime(elapsedTime))
                        .font(.system(size: 28, weight: .bold, design: .monospaced))
                        .foregroundColor(.blue)
                }
                
                // 📊 Progress Bar
                VStack(alignment: .leading) {
                    Text("Ride Progress")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 12)
                        
                        Capsule()
                            .fill(Color.green)
                            .frame(width: rideProgress * 300, height: 12)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // ✅ Complete Ride Button
                Button(action: {
                    timer?.invalidate()
                    rideCompleted = true
                }) {
                    Text("Mark as Completed ✅")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .onAppear {
            startRideTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
        .navigationDestination(isPresented: $rideCompleted) {
            RideCompletedScreen(
                pickupLocation: booking.fromLocation,
                dropoffLocation: booking.toLocation,
                departureDate: booking.bookingTime,
                seatPrice: booking.fare ?? "0",
                passengerName: "Passenger",
                seatsBooked: 1
            )
        }
    }
    
    // MARK: - Helpers
    private func startRideTimer() {
        rideStartTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime = Date().timeIntervalSince(rideStartTime)
            rideProgress = min(CGFloat(elapsedTime / 120.0), 1.0) // fake demo
        }
    }
    
    private func formatElapsedTime(_ seconds: TimeInterval) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%02d:%02d", mins, secs)
    }
}
