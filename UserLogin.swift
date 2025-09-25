import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    @State private var showAlert = false
    @State private var showMessage: String = ""
    @State private var welcomeQuote: String = ""
    
    // Array of welcome quotes
    let quotes = [
        "READY TO HIT THE ROAD?",
        "ANOTHER ADVENTURE AWAITS!",
        "LET'S MAKE YOUR JOURNEY SMOOTH!",
        "TIME TO RIDE IN STYLE!",
        "WELCOME BACK, DRIVER!",
        "YOUR NEXT RIDE IS CALLING!",
        "LET'S ROLL!",
        "ADVENTURE IS OUT THERE!",
        "DRIVE SAFELY AND ENJOY!",
        "FASTEN YOUR SEATBELT, LET'S GO!"
    ]

    var body: some View {
        NavigationStack {
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

                VStack(alignment: .leading, spacing: 16) {
                  
                   

                    Spacer().frame(height: 20)

                    Text("ShareRide")
                        .font(.title)
                        .fontWeight(.bold)

                    // Dynamic welcome quote
                    Text(welcomeQuote)
                        .font(.title3)
                        .fontWeight(.semibold)

                    Text("Let's get you on the road.")
                        .foregroundColor(.gray)

                    // Email Field
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray5))
                        .overlay(
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.gray)
                                TextField("Enter your email", text: $email)
                                    .autocapitalization(.none)
                                    .keyboardType(.emailAddress)
                            }
                            .padding()
                        )
                        .frame(height: 50)

                    // Password Field
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray5))
                        .overlay(
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.gray)
                                SecureField("Enter your password", text: $password)
                            }
                            .padding()
                        )
                        .frame(height: 50)

                    // Login Button
                    Button(action: {
                        if email.isEmpty || password.isEmpty {
                            errorMessage = "Please enter both email and password."
                            showError = true
                        } else {
                            showError = false
                            getLoginApi()
                        }
                    }) {
                        Text("Log In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)

                    if showError {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Forgot password
                    HStack {
                        Text("Forgot password?")
                        Spacer()
                        NavigationLink(destination: ResetPasswordView()) {
                            Text("Reset")
                                .foregroundColor(.purple)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.purple)
                        }
                    }

                    // Sign Up link
                    HStack {
                        Text("New here?")
                        Spacer()
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                                .foregroundColor(.purple)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.purple)
                        }
                    }

                    Spacer()
                }
                .padding()
                .onAppear {
                    // Pick a quote based on email hash for consistency
                    let index = abs(email.hashValue) % quotes.count
                    welcomeQuote = quotes[index]
                }
                .navigationTitle("")
                .navigationBarHidden(true)
                .navigationDestination(isPresented: $isLoggedIn) {
                    RideOptionView()
                }
                .alert("Alert", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(showMessage)
                }
            }
        }
    }

    func getLoginApi() {
        let formData = [
            "Email": email,
            "Password": password
        ]

        APIHandler().postAPIValues(type: LoginModel.self, apiUrl: APIList.login, method: "POST", formData: formData) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if data.status == true {
                        DataManager.shared.userData = data.user
                        isLoggedIn = true
                        UserDefaults.standard.set(email, forKey: "logged_in_email")
                        if let savedDriverEmail = UserDefaults.standard.string(forKey: "driver_email"),
                           savedDriverEmail != email {
                            UserDefaults.standard.removeObject(forKey: "registered_driver")
                            UserDefaults.standard.removeObject(forKey: "driver_email")
                        }
                    } else {
                        showAlert = true
                        showMessage = data.message
                    }
                }
            case .failure(let error):
                print("❌ Error decoding login response: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    showAlert = true
                    showMessage = "Something went wrong!"
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
