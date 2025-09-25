import SwiftUI

// MARK: - Data Model
struct RideHistoryModel: Identifiable {
    let id = UUID()
    let name: String
    let time: String
    let status: RideHistoryStatus
    let pickup: String
    let dropoff: String
    let price: String?
    let rating: Double?
    let statusMessage: String?
    let image: String
    let dateInfo: String
}

enum RideHistoryStatus {
    case completed, cancelled, pending
}

// MARK: - Main View
struct RideHistoryOfferView: View {
    @State private var selectedTab = "All Rides"
    private let tabs = ["All Rides", "Completed", "Cancelled"]

    private let rides: [RideHistoryModel] = [
        RideHistoryModel(
            name: "Sarah Wilson", time: "2:30 PM", status: .completed,
            pickup: "123 Main St, Downtown", dropoff: "456 Park Ave, Uptown",
            price: "$24.50", rating: 4.8, statusMessage: nil,
            image: "person.circle.fill", dateInfo: "Today"
        ),
        RideHistoryModel(
            name: "Michael Brown", time: "10:15 AM", status: .cancelled,
            pickup: "789 Oak Rd, Westside", dropoff: "321 Pine St, Eastside",
            price: nil, rating: nil, statusMessage: "Driver not responding",
            image: "person.circle", dateInfo: "Today"
        ),
        RideHistoryModel(
            name: "Emma Davis", time: "4:45 PM", status: .pending,
            pickup: "567 Elm St, Northside", dropoff: "890 Maple Ave, Southside",
            price: nil, rating: nil, statusMessage: nil,
            image: "person.crop.circle", dateInfo: "Yesterday"
        ),
        RideHistoryModel(
            name: "Liam Johnson", time: "6:00 PM", status: .completed,
            pickup: "12 Lakeview Blvd", dropoff: "34 Seaside Lane",
            price: "$30.00", rating: 4.9, statusMessage: nil,
            image: "person.fill", dateInfo: "Yesterday"
        ),
        RideHistoryModel(
            name: "Olivia Brown", time: "9:15 AM", status: .cancelled,
            pickup: "88 Hilltop Ave", dropoff: "17 River Rd",
            price: nil, rating: nil, statusMessage: "Rider cancelled",
            image: "person.circle.fill", dateInfo: "2 days ago"
        ),
        RideHistoryModel(
            name: "Noah Smith", time: "11:20 AM", status: .completed,
            pickup: "100 Cherry St", dropoff: "200 Peach Ave",
            price: "$20.00", rating: 4.6, statusMessage: nil,
            image: "person.circle", dateInfo: "3 days ago"
        )
    ]

    var filteredRides: [RideHistoryModel] {
        switch selectedTab {
        case "Completed": return rides.filter { $0.status == .completed }
        case "Cancelled": return rides.filter { $0.status == .cancelled }
        default: return rides
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                VStack(alignment: .leading) {
                    // Header Stats
                    HStack {
                        VStack(alignment: .leading) {
                            Text("156")
                                .font(.title2).bold()
                            Text("Total Rides")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("32")
                                .font(.title2).bold()
                            Text("Rides this month")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)

                    // Tabs
                    HStack(spacing: 8) {
                        ForEach(tabs, id: \.self) { tab in
                            Button(action: {
                                selectedTab = tab
                            }) {
                                Text(tab)
                                    .font(.subheadline)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(selectedTab == tab ? Color.purple.opacity(0.15) : Color(.systemGray5))
                                    .foregroundColor(selectedTab == tab ? .purple : .black)
                                    .cornerRadius(16)
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Ride Cards
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(filteredRides) { ride in
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text("\(ride.dateInfo), \(ride.time)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Circle()
                                            .fill(color(for: ride.status))
                                            .frame(width: 8, height: 8)
                                        Text(text(for: ride.status))
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }

                                    HStack(alignment: .top, spacing: 12) {
                                        Image(systemName: ride.image)
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                            .foregroundColor(.purple)

                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(ride.name)
                                                .font(.headline)

                                            if let message = ride.statusMessage {
                                                Text(message)
                                                    .font(.caption)
                                                    .foregroundColor(.red)
                                            }

                                            HStack(spacing: 4) {
                                                Image(systemName: "mappin.and.ellipse")
                                                    .font(.caption)
                                                Text(ride.pickup)
                                                    .font(.caption)
                                            }

                                            HStack(spacing: 4) {
                                                Image(systemName: "mappin")
                                                    .font(.caption)
                                                Text(ride.dropoff)
                                                    .font(.caption)
                                            }

                                            HStack {
                                                if let price = ride.price {
                                                    Text(price)
                                                        .fontWeight(.semibold)
                                                }

                                                Spacer()

                                                if let rating = ride.rating {
                                                    HStack(spacing: 4) {
                                                        Image(systemName: "star.fill")
                                                            .foregroundColor(.yellow)
                                                            .font(.caption)
                                                        Text(String(format: "%.1f", rating))
                                                            .font(.caption)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                        .padding(.bottom, 90) // Space for bottom bar
                    }
                }
                .navigationTitle("Ride History")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            // Back action
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.black)
                    }
                }
            }

            // MARK: - Bottom Navigation Bar
            Divider()
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                        .font(.caption)
                }
                .foregroundColor(.gray)
                Spacer()
                VStack {
                    Image(systemName: "car.fill")
                    Text("Rides")
                        .font(.caption)
                }
                .foregroundColor(.purple)
                Spacer()
                VStack {
                    Image(systemName: "person")
                    Text("Profile")
                        .font(.caption)
                }
                .foregroundColor(.gray)
                Spacer()
            }
            .padding(.vertical, 10)
            .background(Color.white)
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    // MARK: - Status helpers
    private func color(for status: RideHistoryStatus) -> Color {
        switch status {
        case .completed: return .green
        case .cancelled: return .red
        case .pending: return .orange
        }
    }

    private func text(for status: RideHistoryStatus) -> String {
        switch status {
        case .completed: return "Completed"
        case .cancelled: return "Cancelled"
        case .pending: return "Pending"
        }
    }
}

// MARK: - Preview
#Preview {
    RideHistoryOfferView()
}
