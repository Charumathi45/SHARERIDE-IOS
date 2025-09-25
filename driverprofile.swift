import SwiftUI

struct DriverProfileView: View {
    @Environment(\.dismiss) private var dismiss

    // 📝 Form fields
    @State private var email = ""
    @State private var emergencyContact = ""
    @State private var address = ""
    @State private var bloodGroup = ""

    // 🚨 Alert
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSuccess = false

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

           
            VStack(spacing: 20) {
                // ✅ Back button and title
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.purple)
                            .font(.title2)
                    }

                    Spacer()

                    Text("Profile")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.purple)

                    Spacer()
                    // Dummy space to center title
                    Color.clear.frame(width: 24)
                }


                // 📌 Form Fields
                inputBox(title: "Email", text: $email)
                inputBox(title: "Emergency Contact", text: $emergencyContact)
                inputBox(title: "Address", text: $address)
                inputBox(title: "Blood Group", text: $bloodGroup)

                // ✅ Submit Button
                Button(action: submitProfile) {
                    Text("Save Profile")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.top, 20)

                Spacer()
            }
            .padding()
            .onAppear(perform: loadDriverInfo) // 👈 load saved profile
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(isSuccess ? "Success 🎉" : "Error ❌"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if isSuccess { dismiss() }
                }
            )
        }
    }

    // MARK: - Load saved profile
    private func loadDriverInfo() {
        if let saved = DataManager.shared.driverProfileInfo {
            self.email = saved.email
            self.emergencyContact = saved.emergencyContact
            self.address = saved.address
            self.bloodGroup = saved.bloodGroup
        }
    }

    // MARK: - Submit Profile
    private func submitProfile() {
        guard !email.isEmpty,
              !emergencyContact.isEmpty,
              !address.isEmpty,
              !bloodGroup.isEmpty else {
            alertMessage = "All fields are required."
            isSuccess = false
            showAlert = true
            return
        }

        let formData: [String: Any] = [
            "email": email,
            "emergency_contact": emergencyContact,
            "address": address,
            "blood_group": bloodGroup
        ]

        APIHandler.shared.postAPIValues(
            type: DriverProfileResponse.self,
            apiUrl: APIList.driverProfile,
            method: "POST",
            formData: formData
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    alertMessage = response.message
                    isSuccess = response.success
                    showAlert = true

                    if response.success {
                        // ✅ Save profile locally
                        let info = DriverProfileInfo(
                            email: email,
                            emergencyContact: emergencyContact,
                            address: address,
                            bloodGroup: bloodGroup
                        )
                        DataManager.shared.driverProfileInfo = info
                    }

                case .failure(let error):
                    alertMessage = "Failed: \(error.localizedDescription)"
                    isSuccess = false
                    showAlert = true
                }
            }
        }
    }

    // MARK: - Input Box Component
    private func inputBox(title: String, text: Binding<String>) -> some View {
        TextField(title, text: text)
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(10)
            .shadow(radius: 3)
            .autocapitalization(.none)
    }
}

// MARK: - Preview
struct DriverProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DriverProfileView()
    }
}
