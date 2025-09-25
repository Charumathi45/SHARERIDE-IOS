import SwiftUI

struct ResetPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var fullName = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""

    var body: some View {
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

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Custom Back Button
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.title3)
                            .padding(8)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .padding(.top, 10)

                    // Title
                    Text("Reset Your Account")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 10)

                    Text("Please provide the required details to recover your account.")
                        .foregroundColor(.gray)
                        .font(.subheadline)

                    Spacer(minLength: 10)

                    // 📦 Input Boxes with clear styling
                    Group {
                        TextField("Enter your email", text: $email)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(12)
                            .shadow(radius: 2)

                        TextField("Enter your full name", text: $fullName)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(12)
                            .shadow(radius: 2)

                        SecureField("Enter new password", text: $newPassword)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(12)
                            .shadow(radius: 2)

                        SecureField("Re-enter new password", text: $confirmPassword)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }

                    Spacer(minLength: 20)

                    Button(action: {
                        // Handle password reset
                    }) {
                        Text("Reset Password")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                    }
                    .padding(.top, 10)

                    Spacer(minLength: 40)
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true) // ✅ Hide default back button
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ResetPasswordView()
        }
    }
}
