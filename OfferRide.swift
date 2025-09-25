import SwiftUI

struct OfferRideView: View {
    @Environment(\.dismiss) private var dismiss // ✅ For back navigation
    
    @State private var pickupLocation = ""
    @State private var dropoffLocation = ""
    @State private var departureDate = Date()
    @State private var availableSeats = ""
    @State private var carDetails = ""
    @State private var seatPrice = ""
    
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    @State private var showSuccessAlert = false
    @State private var navigateToOfferedRide = false
    
    @State private var lastPostedRide: PreviousOfferDatum? = nil
    
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
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Plan to drive somewhere? Share your ride!")
                            .font(.subheadline)
                            .foregroundColor(.purple)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Group {
                            Text("Driver ID: \(String(describing: DataManager.shared.userData?.id ?? ""))")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.purple.opacity(0.4), lineWidth: 1)
                                )
                                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                            
                            inputField(icon: "mappin.and.ellipse", placeholder: "Enter pickup location", text: $pickupLocation)
                            inputField(icon: "mappin.and.ellipse", placeholder: "Enter drop-off location", text: $dropoffLocation)
                            datePickerField(icon: "calendar", label: "Departure Date", date: $departureDate)
                            inputField(icon: "person.3.fill", placeholder: "Available seats", text: $availableSeats)
                            inputField(icon: "car.fill", placeholder: "Car model & plate number (optional)", text: $carDetails)
                        
                            // ✅ Hint text above price field
                            Text("If you want to earn money or help someone, set a price per seat:")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            inputField(icon: "tag.fill", placeholder: "Set price per seat (optional)", text: $seatPrice)
                        }
                        
                        HStack {
                            Image(systemName: "nosign")
                                .foregroundColor(.red)
                            Text("Smoking & alcohol not allowed")
                                .foregroundColor(.red)
                                .font(.footnote)
                        }
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(10)
                        
                        Button("Post Ride") {
                            postRide()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .padding()
                }
            }
            .navigationTitle("OFFER A RIDE")
            .navigationBarBackButtonHidden(true) // ❌ Hide default
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
            
            .alert("Error", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
            
            .alert("Success", isPresented: $showSuccessAlert) {
                Button("OK", role: .cancel) {
                    navigateToOfferedRide = true
                }
            } message: {
                Text("Your ride is successfully posted.")
            }
            
            .navigationDestination(isPresented: $navigateToOfferedRide) {
                OfferedRide(postedRide: lastPostedRide)
            }
        }
    }
    
    // MARK: - Input Field
    private func inputField(icon: String, placeholder: String, text: Binding<String>) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            TextField(placeholder, text: text)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.purple.opacity(0.4), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
    
    // MARK: - Date Picker Field
    private func datePickerField(icon: String, label: String, date: Binding<Date>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            DatePicker("", selection: date, in: Date()..., displayedComponents: [.date])
                .datePickerStyle(.compact)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.purple.opacity(0.4), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
    
    // MARK: - API Call
    private func postRide() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: departureDate)
        
        var params: [String: Any] = [
            "driver_id": DataManager.shared.userData?.id ?? "",
            "pickup_location": pickupLocation,
            "drop_location": dropoffLocation,
            "departure_date": dateString,
            "available_seats": availableSeats,
            "car_details": carDetails
        ]
        
        // ✅ Add seat_price only if not empty
        if !seatPrice.trimmingCharacters(in: .whitespaces).isEmpty {
            params["seat_price"] = seatPrice
        }
        
        APIHandler.shared.postAPIValues(
            type: OfferRideResponse.self,
            apiUrl: APIList.offerRide,
            method: "POST",
            formData: params
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if response.status.lowercased() == "success" {
                        lastPostedRide = PreviousOfferDatum(
                            id: Int(DataManager.shared.userData?.id ?? "0") ?? 0,
                            pickupLocation: pickupLocation,
                            dropoffLocation: dropoffLocation,
                            travelDate: dateString,
                            travelTime: "N/A",
                            passengerCount: Int(availableSeats) ?? 0,
                            driverNote: "",
                            seatPrice: seatPrice.isEmpty ? "Free" : seatPrice
                        )
                        showSuccessAlert = true
                    } else {
                        errorMessage = response.message
                        showErrorAlert = true
                    }
                    
                case .failure(let error):
                    errorMessage = "Failed to post ride: \(error.localizedDescription)"
                    showErrorAlert = true
                }
            }
        }
    }
}

// MARK: - Preview
struct OfferRideView_Previews: PreviewProvider {
    static var previews: some View {
        OfferRideView()
    }
}
