import SwiftUI

struct AdminDashboardView: View {
    @Environment(\.dismiss) var dismiss
    
    // Existing navigation states
    @State private var showDriverVerification = false
    @State private var showBookingStatus = false
    @State private var showRideManagement = false
    @State private var showUserList = false
    @State private var showFeedbackReport = false
    
    // Side menu states
    @State private var showMenu = false
    @State private var selectedMenu: String? = nil
    
    var body: some View {
        ZStack {
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
                // Header with Menu + Title
                HStack {
                    Button(action: { withAnimation { showMenu.toggle() } }) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Admin Dashboard")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Dashboard Cards
                VStack(spacing: 20) {
                    Button { showDriverVerification = true } label: {
                        AdminDashboardCard(
                            icon: "doc.text.fill",
                            title: "License Review",
                            subtitle: "Review driver license & RC",
                            color: .purple
                        )
                    }
                    
                    Button { showBookingStatus = true } label: {
                        AdminDashboardCard(
                            icon: "checkmark.seal.fill",
                            title: "Booking status",
                            subtitle: "Passengers booking status",
                            color: .purple
                        )
                    }
                    
                    Button { showRideManagement = true } label: {
                        AdminDashboardCard(
                            icon: "car.2.fill",
                            title: "Ride Management",
                            subtitle: "Monitor active & past rides",
                            color: .purple
                        )
                    }
                    
                    Button { showUserList = true } label: {
                        AdminDashboardCard(
                            icon: "person.3.fill",
                            title: "User List",
                            subtitle: "View registered passengers & drivers",
                            color: .purple
                        )
                    }
                    
                    Button { showFeedbackReport = true } label: {
                        AdminDashboardCard(
                            icon: "bubble.left.and.bubble.right.fill",
                            title: "Feedback Report",
                            subtitle: "Review ride feedback & ratings",
                            color: .purple
                        )
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: 500)
                
                Spacer()
            }
            
            // Side Menu Overlay
            if showMenu {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture { withAnimation { showMenu = false } }
                
                SideMenuView { option in
                    if option.isEmpty {
                        // Close menu without selecting
                        withAnimation { showMenu = false }
                    } else {
                        selectedMenu = option
                        withAnimation { showMenu = false }
                    }
                }
                .transition(.move(edge: .leading))
            }
        }
        // Navigation destinations
        .navigationDestination(isPresented: $showDriverVerification) {
            LicenseReview()
        }
        .navigationDestination(isPresented: $showBookingStatus) {
            BookingStatusView()
        }
        .navigationDestination(isPresented: $showRideManagement) {
            RideManagementScreen()
        }
        .navigationDestination(isPresented: $showUserList) {
            UserListView()
        }
        .navigationDestination(isPresented: $showFeedbackReport) {
            FeedbackSelectionView()
        }
        .navigationDestination(item: $selectedMenu) { menu in
            switch menu {
            case "Driver Profile":
                DriverProfileView()
            case "Settings":
                SettingsView()
            case "Log Out":
                LoginView()
            default:
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Dashboard Card
struct AdminDashboardCard: View {
    var icon: String
    var title: String
    var subtitle: String
    var color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 50, height: 50)
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: color.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Side Menu with Small Back Button
struct SideMenuView: View {
    var onSelect: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Small back button
            HStack {
                Button(action: { onSelect("") }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.2))
                        .clipShape(Circle())
                }
                Spacer()
            }
            .padding(.top, 40)
            
            // Menu options
            Button("Profile") { onSelect("Driver Profile") }
            Button("Settings") { onSelect("Settings") }
            Button("Log Out") { onSelect("Log Out") }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(width: 250, alignment: .leading)
        .background(Color.purple)
        .foregroundColor(.white)
        .ignoresSafeArea(edges: .vertical)
    }
}

// MARK: - FeedbackSelectionView
struct FeedbackSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showOfferFeedback = false
    @State private var showRequestFeedback = false
    
    var body: some View {
        ZStack {
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
            
            VStack(spacing: 20) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Feedback Report")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding()
                
                Button {
                    showOfferFeedback = true
                } label: {
                    AdminDashboardCard(
                        icon: "car.fill",
                        title: "Offer Ride Feedback",
                        subtitle: "Feedback from passengers about drivers",
                        color: .purple
                    )
                }
                
                Button {
                    showRequestFeedback = true
                } label: {
                    AdminDashboardCard(
                        icon: "person.fill",
                        title: "Request Ride Feedback",
                        subtitle: "Feedback from drivers about passengers",
                        color: .purple
                    )
                }
                
                Spacer()
            }
        }
        .navigationDestination(isPresented: $showOfferFeedback) {
            OfferRideFeedbackPage()
        }
        .navigationDestination(isPresented: $showRequestFeedback) {
            RequestRideFeedbackPage()
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AdminDashboardView()
    }
}
