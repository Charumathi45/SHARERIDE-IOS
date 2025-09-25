import SwiftUI

struct OTPVerifyView: View {
    let pickupLocation: String
    let dropoffLocation: String
    let departureDate: String
    let seatPrice: String
    let passengerName: String
    let seatsBooked: Int
    
    @State private var otpFields: [String] = ["", "", "", ""]
    @FocusState private var focusedIndex: Int?
    @State private var showRideCompleted = false
    
    var body: some View {
        VStack(spacing: 30) {
            
            // Title
            Text("Verify OTP")
                .font(.title2)
                .fontWeight(.semibold)
            
            // Subtitle / Instruction
            Text("Enter the 4-digit code sent to your number")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // OTP Input Fields
            HStack(spacing: 16) {
                ForEach(0..<4, id: \.self) { index in
                    ZStack {
                        Rectangle()
                            .stroke(Color.purple, lineWidth: 1)
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                        
                        TextField("", text: $otpFields[index])
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 60, height: 60)
                            .focused($focusedIndex, equals: index)
                            .font(.title2)
                            .onChange(of: otpFields[index]) { _ in
                                // Limit input to 1 character
                                if otpFields[index].count > 1 {
                                    otpFields[index] = String(otpFields[index].prefix(1))
                                }
                                // Move focus to next field
                                if !otpFields[index].isEmpty && index < 3 {
                                    focusedIndex = index + 1
                                }
                            }
                    }
                }
            }
            
            // Verify & Start Ride Button
            Button("Verify & Start Ride") {
                showRideCompleted = true
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .onAppear {
            focusedIndex = 0
        }
        // Ride Completed Screen Sheet
        .sheet(isPresented: $showRideCompleted) {
            RideCompletedScreen(
                pickupLocation: pickupLocation,
                dropoffLocation: dropoffLocation,
                departureDate: departureDate,
                seatPrice: seatPrice,
                passengerName: passengerName,
                seatsBooked: seatsBooked
            )
        }
    }
}

#Preview {
    OTPVerifyView(
        pickupLocation: "Chennai",
        dropoffLocation: "Bangalore",
        departureDate: "2025-08-01",
        seatPrice: "500",
        passengerName: "John Smith",
        seatsBooked: 2
    )
}
