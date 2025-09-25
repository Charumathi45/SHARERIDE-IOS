import SwiftUI

struct RideOptionView: View {
    @State private var goRequest = false
    @State private var giveOffer = false
    @State private var animateCards = false

    var body: some View {
        NavigationStack {
            ZStack {
                // 🌈 Background: Smooth purple + white blend
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white,
                        Color.purple.opacity(0.9),
                        Color.white
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 30) {
                    
                    // 👋 Show user's name if available
                    if let userData = DataManager.shared.userData,
                       !userData.name.isEmpty {
                        Text("Hello, \(userData.name)!")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.purple)
                            .padding(.horizontal)
                            .padding(.top, 30)
                    }

                    Text("How would you like to ride today?")
                        .font(.title2.bold())
                        .foregroundColor(.purple)
                        .padding(.horizontal)
                        .padding(.top, 10)

                    VStack(spacing: 20) {
                        // 🚘 Request a Ride
                        Button {
                            goRequest = true
                        } label: {
                            RideCard(
                                icon: "car.fill",
                                title: "Request a Ride",
                                subtitle: "Find a ride going your way"
                            )
                            .scaleEffect(animateCards ? 1 : 0.8)
                            .opacity(animateCards ? 1 : 0)
                            .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.2), value: animateCards)
                        }

                        // 🚘 Offer a Ride
                        Button {
                            giveOffer = true
                        } label: {
                            RideCard(
                                icon: "steeringwheel",
                                title: "Offer a Ride",
                                subtitle: "Share your empty seats and earn or help"
                            )
                            .scaleEffect(animateCards ? 1 : 0.8)
                            .opacity(animateCards ? 1 : 0)
                            .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.4), value: animateCards)
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: 500)

                    Spacer()
                }
                // MARK: - Navigation Links
                .navigationDestination(isPresented: $goRequest) {
                    RiderOptions()
                }
                .navigationDestination(isPresented: $giveOffer) {
                    OfferedRide()
                }
            }
            .onAppear {
                animateCards = true
            }
        }
    }
}

// 🔥 RideCard styled same as RoleCard (purple accent + white background)
struct RideCard: View {
    var icon: String
    var title: String
    var subtitle: String

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.purple.opacity(0.15))
                    .frame(width: 55, height: 55)
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.purple)
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
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.purple.opacity(0.2), radius: 10, x: 0, y: 6)
        )
    }
}

#Preview {
    RideOptionView()
}
