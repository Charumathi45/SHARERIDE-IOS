import SwiftUI
struct BookingStatusView: View {
    // Mock booking data
    let bookings: [BookingStatus] = [
        BookingStatus(id: 1, passengerName: "Charu", pickup: "Trichy", dropoff: "Chennai", date: "2025-08-12", seats: 2, price: "₹150"),
        BookingStatus(id: 2, passengerName: "varshinie", pickup: "Madurai", dropoff: "Coimbatore", date: "2025-08-15", seats: 1, price: "₹200"),
        BookingStatus(id: 3, passengerName: "sanjay", pickup: "Salem", dropoff: "Trichy", date: "2025-08-18", seats: 3, price: "₹90"),
        BookingStatus(id: 4, passengerName: "guna", pickup: "velacherry", dropoff: "tiruttani", date: "2025-08-18", seats: 4, price: "₹50")
    ]
    
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
            .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(bookings) { booking in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(booking.passengerName)
                                .font(.headline)
                                .foregroundColor(.purple)
                            
                            Text("From: \(booking.pickup) → To: \(booking.dropoff)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Text("Date: \(booking.date)")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Text("Seats: \(booking.seats)")
                                    .font(.caption)
                                Spacer()
                                Text(booking.price)
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(16)
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Booking Status")
    }
}

// MARK: - Mock Model
struct BookingStatus: Identifiable {
    let id: Int
    let passengerName: String
    let pickup: String
    let dropoff: String
    let date: String
    let seats: Int
    let price: String
}

#Preview {
    NavigationStack {
        BookingStatusView()
    }
}
