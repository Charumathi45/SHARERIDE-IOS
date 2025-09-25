import SwiftUI

struct DriverRegistrationView: View {
    @Environment(\.dismiss) private var dismiss // ✅ For back navigation

    @State private var fullName = ""
    @State private var mobileNumber = ""
    @State private var licenseNumber = ""
    @State private var rcNumber = ""
    @State private var vehicleType = ""
    @State private var carModel = ""

    @State private var showSuccessAlert = false
    @State private var navigateToOfferRide = false

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

                ScrollView {
                    VStack(spacing: 24) {
                        Group {
                            InputField(icon: "person", placeholder: "Full Name", text: $fullName)
                            InputField(icon: "phone", placeholder: "Mobile Number", text: $mobileNumber)
                            InputField(icon: "creditcard", placeholder: "License Number", text: $licenseNumber)
                        }

                        SectionTitle("Vehicle Details")
                        InputField(icon: "doc.text", placeholder: "RC Number", text: $rcNumber)
                        InputField(icon: "car", placeholder: "Vehicle Type", text: $vehicleType)
                        InputField(icon: "car.fill", placeholder: "Car Model", text: $carModel)

                        Button("Submit") {
                            registerDriver()
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                        .padding(.horizontal)

                        Spacer(minLength: 40)

                        NavigationLink(destination: OfferRideView(), isActive: $navigateToOfferRide) {
                            EmptyView()
                        }
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("DRIVER REGISTER")
            .navigationBarBackButtonHidden(true) // ❌ Hide default back
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
            }
            .alert("Success", isPresented: $showSuccessAlert) {
                Button("OK") {
                    navigateToOfferRide = true
                }
            } message: {
                Text("Driver registration successful!")
            }
            .onAppear {
                if let savedDriver = DataManager.shared.driverInfo {
                    // 🟣 Second time or later → load full driver info
                    fullName = savedDriver.fullName
                    mobileNumber = savedDriver.mobileNumber
                    licenseNumber = savedDriver.licenseNumber
                    rcNumber = savedDriver.rcNumber
                    vehicleType = savedDriver.vehicleType
                    carModel = savedDriver.carModel
                } else if let user = DataManager.shared.userData {
                    // 🟣 First time → only show name from signup
                    fullName = user.name   // ✅ just show signup name
                }
            }
        }
    }

    // MARK: - Register Driver Function
    private func registerDriver() {
        guard let url = URL(string: APIList.driverRegister) else { return }

        let parameters: [String: String] = [
            "full_name": fullName,
            "mobile_number": mobileNumber,
            "license_number": licenseNumber,
            "rc_number": rcNumber,
            "vehicle_type": vehicleType,
            "car_model": carModel
        ]

        let bodyString = parameters
            .map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" }
            .joined(separator: "&")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyString.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let response = try JSONDecoder().decode(DriverRegisterResponse.self, from: data)
                print("Response:", response)

                if response.success {
                    let info = DriverInfo(
                        fullName: fullName,
                        mobileNumber: mobileNumber,
                        licenseNumber: licenseNumber,
                        rcNumber: rcNumber,
                        vehicleType: vehicleType,
                        carModel: carModel
                    )
                    DataManager.shared.driverInfo = info

                    DispatchQueue.main.async {
                        showSuccessAlert = true
                    }
                } else {
                    print("Server Error: \(response.message)")
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
}

// MARK: - Reusable Input Field
struct InputField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
        }
        .padding()
        .background(Color.white.opacity(0.8)) // ✅ keep fields visible on gradient
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

// MARK: - Section Title View
struct SectionTitle: View {
    var title: String
    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}

struct DriverRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        DriverRegistrationView()
    }
}
