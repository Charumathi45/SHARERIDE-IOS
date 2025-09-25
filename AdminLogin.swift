import SwiftUI

struct AdminLoginView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var adminID: String = ""
    @State private var password: String = ""
    @State private var navigateToDashboard = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 🌈 Gradient background
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
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .medium))
                        }
                        Spacer()
                    }
                    
                    // 🏷️ Title
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SHARERIDE")
                            .font(.largeTitle)
                            .bold()
                        Text("Drive Smarter, Ride Together.")
                            .font(.subheadline)
                            .foregroundColor(.purple)
                    }
                    
                    // 🧾 Input Fields — separate boxes
                    InputBox(title: "Admin ID", placeholder: "Enter your admin ID", text: $adminID)
                    InputBox(title: "Password", placeholder: "Enter your password", text: $password, isSecure: true)
                    
                    // ✅ Login Button
                    Button(action: {
                        if validateForm() {
                            loginAdmin()
                        }
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    // 🔑 Forgot Password
                    HStack {
                        Text("Forgot password?")
                        Spacer()
                        NavigationLink(destination: ResetPasswordView()) {
                            HStack(spacing: 4) {
                                Text("Reset")
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.purple)
                        }
                    }
                    
                    // ✍️ Sign Up
                    HStack {
                        Text("New here?")
                        Spacer()
                        NavigationLink(destination: AdminSignUpView()) {
                            HStack(spacing: 4) {
                                Text("Sign Up")
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.purple)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationDestination(isPresented: $navigateToDashboard) {
                    AdminDashboardView()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // MARK: - Validation
    private func validateForm() -> Bool {
        if adminID.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please fill all fields."
            showAlert = true
            return false
        }
        return true
    }
    
    // MARK: - API Call
    private func loginAdmin() {
        let formData: [String: Any] = [
            "admin_id": adminID,
            "password": password
        ]
        
        APIHandler.shared.postAPIValues(
            type: AdminLoginResponse.self,
            apiUrl: APIList.adminLogin,
            method: "POST",
            formData: formData
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if response.success {
                        navigateToDashboard = true
                    } else {
                        alertMessage = response.message
                        showAlert = true
                    }
                case .failure(let error):
                    alertMessage = "Login failed: \(error.localizedDescription)"
                    showAlert = true
                }
            }
        }
    }
}

// MARK: - Reusable InputBox
struct InputBox: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
            }
        }
        .padding(.horizontal, 0)
    }
}
