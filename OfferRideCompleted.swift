import SwiftUI

struct RideCompletedScreen: View {
    let pickupLocation: String
    let dropoffLocation: String
    let departureDate: String
    let seatPrice: String
    let passengerName: String
    let seatsBooked: Int

    @State private var rating: Int = 0
    @State private var comment: String = ""
    @State private var showSuccessAlert = false
    @State private var showErrorAlert = false
    @State private var goToLogin = false
    @State private var showLogoutAlert = false

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

                VStack(spacing: 24) {
                    // Title
                    Text("🎉 Ride Completed!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)

                    // Ride Details Card
                    VStack(alignment: .leading, spacing: 12) {
                        detailRow(title: "From", value: pickupLocation)
                        detailRow(title: "To", value: dropoffLocation)
                        detailRow(title: "Date", value: departureDate)
                        detailRow(title: "Passenger", value: passengerName)
                        detailRow(title: "Seats Booked", value: "\(seatsBooked)")
                        detailRow(title: "Total Fare", value: "₹\(seatPrice)")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    .shadow(radius: 4)
                    .padding(.horizontal)

                    // ⭐️ Rating
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Rate your experience")
                            .font(.headline)

                        HStack {
                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= rating ? "star.fill" : "star")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.purple)
                                    .onTapGesture {
                                        withAnimation {
                                            rating = star
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)

                    // 📝 Feedback
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Feedback")
                            .font(.headline)

                        TextEditor(text: $comment)
                            .frame(height: 100)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    // ✅ Submit Feedback Button
                    Button {
                        if comment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            showErrorAlert = true
                        } else {
                            showSuccessAlert = true
                            comment = ""
                            rating = 0
                        }
                    } label: {
                        Text("Submit Feedback")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    // 🔹 Logout Button
                    Button {
                        showLogoutAlert = true
                    } label: {
                        Text("Logout")
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
            // Alerts
            .alert(isPresented: $showSuccessAlert) {
                Alert(title: Text("Feedback Submitted ✅"),
                      message: Text("Thanks for your feedback!"),
                      dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Feedback Required ⚠️"),
                      message: Text("Please enter your feedback before submitting."),
                      dismissButton: .default(Text("OK")))
            }
            // Logout confirmation
            .alert("Logout", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Logout", role: .destructive) {
                    goToLogin = true
                }
            } message: {
                Text("Are you sure you want to logout?")
            }
            // Navigation to LoginView
            .navigationDestination(isPresented: $goToLogin) {
                LoginView()
            }
        }
    }

    // MARK: - Detail Row View
    func detailRow(title: String, value: String) -> some View {
        HStack {
            Text(title + ":")
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    RideCompletedScreen(
        pickupLocation: "Chennai",
        dropoffLocation: "Bangalore",
        departureDate: "2025-08-01",
        seatPrice: "500",
        passengerName: "John Smith",
        seatsBooked: 2
    )
}
