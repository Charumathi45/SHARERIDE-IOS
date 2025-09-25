import SwiftUI

struct PreviousOffers: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var bookings: [PreviousRidedata] = []
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            ZStack {
                // 🌈 Background Gradient
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

                VStack(alignment: .leading, spacing: 16) {
                    
                    if let booking = bookings.last {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("\(booking.pickupLocation) → \(booking.dropLocation)")
                                    .font(.headline)
                                Spacer()
                                Text("₹\(booking.seatPrice)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.purple)
                            }
                            
                                                        
                            Text("Seats Available: \(booking.availableSeats)")
                                .font(.subheadline)
                            
                            Text("Driver: \(booking.driverID)")
                                .font(.subheadline)
                            
                            Text("Booked on \(formattedDate(booking.departureDate))")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 3)
                    } else if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ProgressView("Loading bookings...")
                            .padding()
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("My Bookings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17, weight: .medium))
                            Text("Back")
                                .font(.system(size: 17))
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
        }
        .onAppear {
            fetchBookings()
        }
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
        let url = APIList.previousRides + "?driver_id=\(DataManager.shared.userData?.id ?? "")"

        APIHandler().getAPIValues(type: PreviousRide.self, apiUrl: url, method: "POST") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if data.status == "success" {
                        bookings = data.rides
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
