import SwiftUI

struct LicenseReview: View {
    @State private var drivers: [DriverRegistration] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            ZStack {
                // 🌈 Updated Gradient (smooth purple + white blend)
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
                
                if isLoading {
                    ProgressView("Loading Drivers...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                        .background(.white.opacity(0.8))
                        .cornerRadius(10)
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(drivers) { driver in
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(driver.full_name)
                                        .font(.headline)
                                        .foregroundColor(.purple)
                                    
                                    Text("📱 \(driver.mobile_number)")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                    
                                    Text("🚘 \(driver.vehicle_type) - \(driver.car_model)")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                    
                                    Text("📑 RC: \(driver.rc_number)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white.opacity(0.9)) // ✅ Box background
                                .cornerRadius(12) // ✅ Rounded box
                                .shadow(radius: 4) // ✅ Light shadow
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Driver Verification")
        }
        .onAppear {
            fetchDrivers()
        }
    }
    
    private func fetchDrivers() {
        guard let url = URL(string: APIList.getRegisteredDrivers) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async { isLoading = false }
            
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received"
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(DriverRegistrationResponse.self, from: data)
                DispatchQueue.main.async {
                    if response.success {
                        self.drivers = response.drivers
                    } else {
                        errorMessage = "Failed to load drivers"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
