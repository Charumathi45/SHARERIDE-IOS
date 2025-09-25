import SwiftUI

struct Ride: Identifiable {
    let id = UUID()
    let passengerName: String
    let pickup: String
    let dropoff: String
    let time: String
}

struct RideManagementScreen: View {
    // ✅ South Indian names & places only
    let rides: [Ride] = [
        Ride(passengerName: "Charu", pickup: "Chennai", dropoff: "Coimbatore", time: "09:00 AM"),
        Ride(passengerName: "Guna", pickup: "Madurai", dropoff: "Trichy", time: "09:30 AM"),
        Ride(passengerName: "Sanjay", pickup: "Bangalore", dropoff: "Mysore", time: "10:15 AM"),
        Ride(passengerName: "Varshinie", pickup: "Hyderabad", dropoff: "Warangal", time: "11:00 AM"),
        Ride(passengerName: "Ravi", pickup: "Kochi", dropoff: "Trivandrum", time: "11:45 AM"),
        Ride(passengerName: "Karthik", pickup: "Chennai", dropoff: "Salem", time: "12:30 PM"),
        Ride(passengerName: "Divya", pickup: "Coimbatore", dropoff: "Erode", time: "01:00 PM"),
        Ride(passengerName: "Arun", pickup: "Vellore", dropoff: "Chennai", time: "01:30 PM"),
        Ride(passengerName: "Sneha", pickup: "Madurai", dropoff: "Thoothukudi", time: "02:15 PM"),
        Ride(passengerName: "Pravin", pickup: "Tirunelveli", dropoff: "Madurai", time: "03:00 PM"),
        Ride(passengerName: "Meena", pickup: "Salem", dropoff: "Namakkal", time: "03:45 PM"),
        Ride(passengerName: "Harish", pickup: "Chennai", dropoff: "Pondicherry", time: "04:20 PM"),
        Ride(passengerName: "Anitha", pickup: "Trichy", dropoff: "Karur", time: "05:00 PM"),
        Ride(passengerName: "Suresh", pickup: "Hyderabad", dropoff: "Vijayawada", time: "05:40 PM"),
        Ride(passengerName: "Priya", pickup: "Kochi", dropoff: "Calicut", time: "06:15 PM"),
        Ride(passengerName: "Vignesh", pickup: "Chennai", dropoff: "Tiruvannamalai", time: "07:00 PM"),
        Ride(passengerName: "Radha", pickup: "Bangalore", dropoff: "Hosur", time: "07:30 PM"),
        Ride(passengerName: "Mohan", pickup: "Trivandrum", dropoff: "Nagercoil", time: "08:15 PM"),
        Ride(passengerName: "Lakshmi", pickup: "Madurai", dropoff: "Dindigul", time: "09:00 PM"),
        Ride(passengerName: "Kiran", pickup: "Coimbatore", dropoff: "Ooty", time: "09:45 PM")
    ]
    
    var body: some View {
        ZStack {
            // 🌈 Smooth purple + white gradient
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
                VStack(spacing: 14) {
                    ForEach(rides) { ride in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(ride.passengerName)
                                .font(.headline)
                                .foregroundColor(.purple)
                            
                            Text("\(ride.pickup) → \(ride.dropoff) • \(ride.time)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.95))
                                .shadow(color: .purple.opacity(0.25), radius: 6, x: 0, y: 4)
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 16)
            }
        }
        .navigationTitle("Ride Management")
    }
}

struct RideManagementScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RideManagementScreen()
        }
    }
}
