import SwiftUI

struct OfferedRide: View {
    var postedRide: PreviousOfferDatum? = nil  // Accept passed-in ride
    
    @State private var myoffer = false
    @State private var continueOffer = false
    @State private var confirmBooking = false  // New state for confirm booking
    
    // Dashboard Menu States
    @State private var showMenu = false
    @State private var driverRegistration = false
    @State private var driverProfile = false
    @State private var settings = false
    @State private var logout = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background
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
                
                Text("Offer!!")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .foregroundColor(.primary)
                
                VStack(spacing: 20) {
                    // My Offers
                    Button { myoffer = true } label: {
                        RideCard(
                            icon: "car.fill",
                            title: "My Previous Offers",
                            subtitle: "Find a ride going your way"
                        )
                    }
                    
                    // Make a New Offer
                    Button { continueOffer = true } label: {
                        RideCard(
                            icon: "steeringwheel",
                            title: "Make a New Offer",
                            subtitle: "Share your empty seats and earn or help"
                        )
                    }
                    
                    // Confirm Booking
                    Button { confirmBooking = true } label: {
                        RideCard(
                            icon: "checkmark.seal.fill",
                            title: "Confirm Booking",
                            subtitle: "View and manage your confirmed bookings"
                        )
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: 500)
                
                Spacer()
            }
            
            // Purple Dashboard Menu
            if showMenu {
                ZStack(alignment: .topLeading) {
                    // Optional overlay to dismiss by tapping outside
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture { withAnimation { showMenu = false } }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        // Small back button
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
                        Button("Driver Registration") {
                            driverRegistration = true
                            toggleMenu()
                        }
                        Button("Driver Profile") {
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
        // Navigation
        .fullScreenCover(isPresented: $myoffer) { PreviousOffers() }
        .fullScreenCover(isPresented: $continueOffer) { OfferRideView() }
        .fullScreenCover(isPresented: $confirmBooking) { ConfirmBooking() }
        .fullScreenCover(isPresented: $driverRegistration) { DriverRegistrationView() }
        .fullScreenCover(isPresented: $driverProfile) { DriverProfileView() }
        .fullScreenCover(isPresented: $settings) { SettingsView() }
        .fullScreenCover(isPresented: $logout) { LoginView() }
    }
    
    private func toggleMenu() {
        withAnimation { showMenu.toggle() }
    }
}
