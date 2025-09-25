import SwiftUI

struct RideCompletedView: View {
    let request: GetCarListData

    @State private var rating: Int = 0
    @State private var comment: String = ""
    
    @State private var showSuccessAlert = false
    @State private var showLogoutAlert = false
    @State private var goToLogin = false

    var body: some View {
        ZStack {
            // 🌈 Gradient Background
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
                VStack(spacing: 24) {
                    Text("🎉 Ride Completed!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)

                    // 🚘 Ride Details Card
                    VStack(alignment: .leading, spacing: 12) {
                        detailRow(title: "From", value: request.pickupLocation)
                        detailRow(title: "To", value: request.dropLocation)
                        detailRow(title: "Date", value: request.departureDate)
                        detailRow(title: "Time", value: getCurrentTime())
                        detailRow(title: "Passenger(s)", value: "\(request.availableSeats)")
                        detailRow(title: "Fare", value: "₹\(request.seatPrice)")
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
                                    .frame(width: 28, height: 28)
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

                    // ✅ Action Buttons
                    VStack(spacing: 12) {
                        // Filled Purple Button
                        Button("Submit Feedback") {
                            showSuccessAlert = true
                            comment = ""
                            rating = 0
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        // Outlined Red Button
                        Button("Logout") {
                            showLogoutAlert = true
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red, lineWidth: 2)
                        )
                        .foregroundColor(.red)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 40)
            }
        }
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("Feedback Submitted ✅"),
                message: Text("Thanks for your feedback!"),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert("Logout", isPresented: $showLogoutAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Logout", role: .destructive) {
                goToLogin = true
            }
        } message: {
            Text("Are you sure you want to logout?")
        }
        .fullScreenCover(isPresented: $goToLogin) {
            LoginView()
        }
    }

    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: Date())
    }

    func detailRow(title: String, value: String) -> some View {
        HStack {
            Text("\(title):")
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
    }
}
