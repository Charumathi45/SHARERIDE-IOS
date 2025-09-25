import SwiftUI

struct BookingListView: View {
    @State private var bookings: [GetBookDatum] = []
    @State private var errorMessage: String?
    let userId = 2 // Replace with actual user ID
    
    var body: some View {
        ZStack {
            // 🌈 Gradient background (instead of systemGray)
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
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(bookings, id: \.userID) { booking in
                        BookingCardView(booking: booking)
                    }
                }
                .padding(.top)
            }
        }
        .onAppear {
            fetchBookings()
        }
    }
    
    private func fetchBookings() {
        let url = APIList.getbooking + "?user_id=\(DataManager.shared.userData?.id ?? "")"
        
        APIHandler().getAPIValues(type: GetBook.self, apiUrl: url, method: "POST") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if data.status == "success" {
                        bookings = data.data
                    }
                }
            case .failure(let error):
                print("❌ Error decoding booking response: \(error.localizedDescription)")
            }
        }
    }
}

struct BookingCardView: View {
    let booking: GetBookDatum
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Text("\(booking.fromLocation) → \(booking.toLocation)")
                    .font(.headline)
                Spacer()
                Text("₹\(booking.fare)")
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
            }
            
            Text("Duration: \(booking.duration)")
                .font(.subheadline)
            
            Text("Seats Available: \(booking.seatsAvailable)")
                .font(.subheadline)
            
            Text("Driver: \(booking.driverName)")
                .font(.subheadline)
            
            HStack(spacing: 8) {
                Text("Rating: \(booking.driverRating)")
                if booking.driverVerified == 1 {
                    Label("Verified", systemImage: "checkmark.seal.fill")
                        .foregroundColor(.green)
                        .font(.caption)
                }
            }
            .font(.subheadline)
            
            Text("Car: \(booking.carModel) | Boot: \(booking.bootSpace)")
                .font(.subheadline)
            
            Text("Booked on \(formattedDate(booking.bookingTime))")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.1), radius: 6, x: 0, y: 3)
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
}
