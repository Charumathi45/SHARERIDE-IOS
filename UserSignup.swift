import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var navigateToHome = false
    @State private var alertMessage = ""
    @State private var showAlert = false

    var body: some View {
        ZStack { // ✅ Added ZStack for gradient background
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

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Spacer().frame(height: 20)

                    // Title
                    Text("Create Your ShareRide Account")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Join the ride-sharing community now.")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    // Input Fields
                    Group {
                        FilledInputField(title: "Full Name", text: $fullName)
                        FilledInputField(title: "Email", text: $email, keyboard: .emailAddress)
                        FilledInputField(title: "Password", text: $password)
                        FilledInputField(title: "Confirm Password", text: $confirmPassword)
                    }

                    // Sign Up Button
                    Button(action: {
                        signUpUser()
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                    }

                    Spacer()

                   
                    }
                
                .padding()
                .navigationDestination(isPresented: $navigateToHome) {
                    LoginView()
                }

                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Sign Up"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
        .navigationBarBackButtonHidden(false) // ✅ Only default back button now
    }

    func signUpUser() {
        guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }

        guard password == confirmPassword else {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }

        let formData: [String: Any] = [
            "name": fullName,
            "email": email,
            "password": password
        ]

        APIHandler.shared.postAPIValues(
            type: SignupResponse.self,
            apiUrl: APIList.signup,
            method: "POST",
            formData: formData
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    alertMessage = response.message
                    showAlert = true
                    if response.success {
                        navigateToHome = true
                    }
                case .failure:
                    alertMessage = "Something went wrong"
                    showAlert = true
                }
            }
        }
    }

    // MARK: - Filled Input Field
    struct FilledInputField: View {
        var title: String
        @Binding var text: String
        var keyboard: UIKeyboardType = .default

        var body: some View {
            TextField(title, text: $text)
                .keyboardType(keyboard)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .foregroundColor(.black)
        }
    }
}

// MARK: - Preview
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
