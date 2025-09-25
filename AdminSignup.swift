import SwiftUI

struct AdminSignUpView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var adminID: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSuccess = false

    var body: some View {
        ZStack {
            // ✅ Gradient Background
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
            .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 24) {
                // 🔙 Back Button
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .medium))
                    }
                    Spacer()
                }

                // 🏷️ Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("ShareRide Admin")
                        .font(.largeTitle)
                        .bold()
                    Text("Create a new admin account")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // 🧾 Separate Input Boxes
                VStack(spacing: 16) {
                    // Each box is separate now
                    inputBox(title: "Admin ID", placeholder: "Enter your admin ID", text: $adminID)
                    inputBox(title: "Email", placeholder: "Enter your email", text: $email)
                    secureBox(title: "Password", placeholder: "Enter your password", text: $password)
                    secureBox(title: "Confirm Password", placeholder: "Re-enter your password", text: $confirmPassword)
                }

                // ✅ Sign Up Button
                Button(action: {
                    registerAdmin()
                }) {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                // 🔁 Link to Login
                HStack {
                    Text("Already an admin?")
                    NavigationLink(destination: AdminLoginView()) {
                        Text("Log In")
                            .foregroundColor(.purple)
                            .underline()
                    }
                }
                .font(.footnote)

                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(isSuccess ? "Success 🎉" : "Error ❌"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if isSuccess {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }

    // MARK: - Separate Input Boxes
    private func inputBox(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            TextField(placeholder, text: text)
                .autocapitalization(.none)
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
        }
    }

    private func secureBox(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            SecureField(placeholder, text: text)
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
        }
    }

    // MARK: - API Call (unchanged)
    private func registerAdmin() {
        guard !adminID.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            alertMessage = "All fields are required."
            isSuccess = false
            showAlert = true
            return
        }

        guard password == confirmPassword else {
            alertMessage = "Passwords do not match."
            isSuccess = false
            showAlert = true
            return
        }

        let formData: [String: Any] = [
            "admin_id": adminID,
            "email": email,
            "password": password,
            "confirm_password": confirmPassword
        ]

        APIHandler.shared.postAPIValues(
            type: AdminSignupResponse.self,
            apiUrl: APIList.adminSignUp,
            method: "POST",
            formData: formData
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    alertMessage = response.message
                    isSuccess = response.success
                    showAlert = true
                case .failure(let error):
                    alertMessage = "Failed to sign up: \(error.localizedDescription)"
                    isSuccess = false
                    showAlert = true
                }
            }
        }
    }
}

// MARK: - Preview
struct AdminSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        // ✅ Removed NavigationView — you should wrap this in parent view instead
        AdminSignUpView()
    }
}
