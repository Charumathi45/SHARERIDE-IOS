import SwiftUI

struct RidePreferenceView: View {
    @State private var animateCards = false

    var body: some View {
        NavigationStack {
            ZStack {
                // 🌈 Smooth purple + white blend background
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
                    // 🏷️ Title
                    Text("HOW WOULD YOU LIKE TO LOGIN?")
                        .font(.title2.bold())
                        .foregroundColor(.purple)
                        .padding(.horizontal)
                        .padding(.top, 30)

                    // 👤 Options with animated entry
                    VStack(spacing: 20) {
                        // 👉 Login as User
                        NavigationLink(destination: LoginView()) {
                            RoleCard(
                                icon: "person.fill",
                                title: "USER",
                                subtitle: "Access ride sharing as a passenger or driver"
                            )
                            .scaleEffect(animateCards ? 1 : 0.8)
                            .opacity(animateCards ? 1 : 0)
                            .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.2), value: animateCards)
                        }
                        .buttonStyle(PlainButtonStyle())

                        // 👉 Login as Admin
                        NavigationLink(destination: AdminLoginView()) {
                            RoleCard(
                                icon: "person.crop.rectangle",
                                title: "ADMIN",
                                subtitle: "Manage and oversee ride activities"
                            )
                            .scaleEffect(animateCards ? 1 : 0.8)
                            .opacity(animateCards ? 1 : 0)
                            .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.4), value: animateCards)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: 500)

                    Spacer()
                }
            }
            .onAppear {
                animateCards = true
            }
        }
    }
}

// 🔥 RoleCard styled clean with purple accent
struct RoleCard: View {
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
                .fill(Color.white) // clean card
                .shadow(color: Color.purple.opacity(0.2), radius: 10, x: 0, y: 6)
        )
    }
}

#Preview {
    RidePreferenceView()
}
