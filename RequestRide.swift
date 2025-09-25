import SwiftUI

struct RequestRideView: View {
    @State private var pickupLocation = ""
    @State private var dropoffLocation = ""
    @State private var travelDate = Date()
    @State private var travelTime = Date()
    @State private var passengerCount = 2
    @State private var driverNote = ""
    @State private var navigateToRideList = false
    @State private var errorMessage = ""
    @State private var showError = false
    
    var formattedTravelDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: travelDate)
    }
    
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
            
            VStack {
                Spacer()
                
                // White Card (same style as Reset screen)
                VStack(alignment: .leading, spacing: 16) {
                    Text("REQUEST A RIDE") // ✅ All Caps
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top)
                    
                    // Pickup
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Enter Pickup Location")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.purple)
                            TextField("Pickup location", text: $pickupLocation)
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
                    
                    // Drop-off
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Enter Drop Location")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.purple)
                            TextField("Drop-off location", text: $dropoffLocation)
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
                    
                    // Date & Time
                    Text("When do you want to travel?")
                        .bold()
                    
                    HStack(spacing: 12) {
                        DatePicker("Select date", selection: $travelDate, in: Date()..., displayedComponents: .date)
                            .labelsHidden()
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple.opacity(0.4), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)

                            .frame(maxWidth: .infinity)
                        
                        DatePicker("Select time", selection: $travelTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple.opacity(0.4), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)

                            .frame(maxWidth: .infinity)
                            .onChange(of: travelTime) { oldValue, newValue in
                                let now = Date()
                                let calendar = Calendar.current
                                if calendar.isDate(travelDate, inSameDayAs: now), newValue < now {
                                    travelTime = now
                                }
                            }
                    }
                    
                    // Passengers
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Number of Passengers").bold()
                        HStack(spacing: 30) {
                            Button(action: {
                                if passengerCount > 1 { passengerCount -= 1 }
                            }) {
                                Image(systemName: "minus")
                                    .frame(width: 32, height: 32)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.purple.opacity(0.4), lineWidth: 1)
                                    )
                                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)

                            }
                            
                            Text("\(passengerCount)")
                                .font(.title3)
                            
                            Button(action: {
                                if passengerCount < 6 {
                                    passengerCount += 1
                                }
                            }) {
                                Image(systemName: "plus")
                                    .frame(width: 32, height: 32)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.purple.opacity(0.4), lineWidth: 1)
                                    )
                                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)

                            }
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
                    
                    // Notes
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Notes to Driver (Optional)").bold()
                        TextEditor(text: $driverNote)
                            .frame(minHeight: 100)
                            .padding(8)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple.opacity(0.4), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)

                    }
                    
                    // Submit Button
                    Button(action: {
                        if pickupLocation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            errorMessage = "Please enter a pickup location."
                            showError = true
                            return
                        }
                        
                        if dropoffLocation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            errorMessage = "Please enter a drop-off location."
                            showError = true
                            return
                        }
                        
                        if passengerCount < 1 {
                            errorMessage = "Please select at least 1 passenger."
                            showError = true
                            return
                        }
                        
                        navigateToRideList = true
                    }) {
                        Text("Request Ride")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                    
                }
                .padding()
                .background(Color.white) // ✅ White card like Reset screen
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding()
                
                Spacer()
            }
        }
        .navigationDestination(isPresented: $navigateToRideList) {
            RideListView(pickupLocation: pickupLocation, dropoffLocation: dropoffLocation, date: formattedTravelDate)
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    RequestRideView()
}


struct GetBook: Codable {
    let status: String
    let data: [GetBookDatum]
}

// MARK: - Datum
struct GetBookDatum: Codable {
    let bookingID, userID: Int
    let fromLocation, toLocation, departureAddress, arrivalAddress: String
    let duration, fare: String
    let seatsAvailable: Int
    let driverName: String
    let driverRating, driverVerified: Int
    let bootSpace, carModel, bookingTime: String

    enum CodingKeys: String, CodingKey {
        case bookingID = "booking_id"
        case userID = "user_id"
        case fromLocation = "from_location"
        case toLocation = "to_location"
        case departureAddress = "departure_address"
        case arrivalAddress = "arrival_address"
        case duration, fare
        case seatsAvailable = "seats_available"
        case driverName = "driver_name"
        case driverRating = "driver_rating"
        case driverVerified = "driver_verified"
        case bootSpace = "boot_space"
        case carModel = "car_model"
        case bookingTime = "booking_time"
    }
}
