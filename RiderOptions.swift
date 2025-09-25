import SwiftUI

struct RiderOptions: View {
    @State private var showLastBookedRide = false
    @State private var showOfferRideView = false
    
    // Dashboard Menu States
    @State private var showMenu = false
    @State private var driverProfile = false
    @State private var settings = false
    @State private var logout = false

    var body: some View {
        ZStack(alignment: .topLeading) {
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

            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    // Small Menu Button
                    // Hamburger Menu Button
                    Button {
                        withAnimation { showMenu.toggle() }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.black)
                    }

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)

                Text("Rider")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .foregroundColor(.primary)

                VStack(spacing: 20) {
                    // My Ride List
                    Button {
                        showLastBookedRide = true
                    } label: {
                        RideCard(
                            icon: "car.fill",
                            title: "My Ride List",
                            subtitle: "Find a ride going your way"
                        )
                    }

                    // Request a Ride
                    Button {
                        showOfferRideView = true
                    } label: {
                        RideCard(
                            icon: "steeringwheel",
                            title: "Request a Ride",
                            subtitle: "Book your next journey easily"
                        )
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: 500)

                Spacer()
            }

            // Purple Dashboard Menu with Small Back Button
            if showMenu {
                ZStack(alignment: .topLeading) {
                    // Dark overlay to tap outside and dismiss
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture { withAnimation { showMenu = false } }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        // Small Back Button
                        HStack {
                            Button(action: { toggleMenu() }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color.black.opacity(0.2))
                                    .clipShape(Circle())
                            }
                            Spacer()
                        }
                        .padding(.top, 40)
                        
                        // Menu Options
                        Button("Passengers Profile") {
                            driverProfile = true
                            toggleMenu()
                        }
                        Button("Settings") {
                            settings = true
                            toggleMenu()
                        }
                        Button("Logout") {
                            logout = true
                            toggleMenu()
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: 220, alignment: .leading)
                    .background(Color.purple)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.top, 70)
                    .padding(.leading, 15)
                    .transition(.move(edge: .leading).combined(with: .opacity))
                    .foregroundColor(.white)
                }
            }
        }
        // MARK: - Navigation Destinations
        .navigationDestination(isPresented: $showLastBookedRide) {
            BookingListView()
        }
        .navigationDestination(isPresented: $showOfferRideView) {
            RequestRideView()
        }
        
        // Dashboard Destinations
        .fullScreenCover(isPresented: $driverProfile) { DriverProfileView() }
        .fullScreenCover(isPresented: $settings) { SettingsView() }
        .fullScreenCover(isPresented: $logout) { LoginView() }
    }
    
    private func toggleMenu() {
        withAnimation { showMenu.toggle() }
    }
}
