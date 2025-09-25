import SwiftUI

struct VerifyRideView: View {
    let request: GetCarListData
    
    @State private var otpDigits = ["5", "7", "7", "4"]
    @FocusState private var focusedIndex: Int?
    @State private var showError = false
    @State private var navigateToInProgress = false
    
    var body: some View {
        ZStack {
            // Background Gradient
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
                VStack(spacing: 30) {
                    
                    // Title
                    Text("Verify Ride")
                        .font(.title.bold())
                    
                    // Ride Details
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Pickup: \(request.pickupLocation)", systemImage: "mappin")
                        Label("Drop: \(request.dropLocation)", systemImage: "mappin.circle")
                        Label("Date: \(request.departureDate)", systemImage: "calendar")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    // OTP Boxes
                    HStack(spacing: 12) {
                        ForEach(0..<4, id: \.self) { index in
                            TextField("", text: $otpDigits[index])
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .frame(width: 50, height: 50)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .focused($focusedIndex, equals: index)
                                .onChange(of: otpDigits[index]) { newValue in
                                    if newValue.count == 1 && index < 3 {
                                        focusedIndex = index + 1
                                    } else if newValue.isEmpty && index > 0 {
                                        focusedIndex = index - 1
                                    }
                                }
                        }
                    }
                    
                    // Start Ride Button
                    Button("Start Ride") {
                        if otpDigits.joined() == "5774" {
                            navigateToInProgress = true
                        } else {
                            showError = true
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    
                    // Note
                    Text("Only share this OTP with your driver")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                } // VStack
                .padding()
            } // ScrollView
            .navigationDestination(isPresented: $navigateToInProgress) {
                RideInProgressView(request: request)
            }
            .alert("Incorrect OTP", isPresented: $showError) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

//MARK: - Ride In Progress View
struct RideInProgressView: View {
    let request: GetCarListData
    @State private var rideEnded = false
    @State private var showDriversCorner = false
    
    var body: some View {
        VStack(spacing: 30) {
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
            Text("Ride In Progress")
                .font(.title.bold())
            
            VStack(alignment: .leading, spacing: 10) {
                Label("Pickup: \(request.pickupLocation)", systemImage: "mappin")
                Label("Drop: \(request.dropLocation)", systemImage: "mappin.circle")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            Spacer()
            
            VStack(spacing: 12) {
                Button("End Ride") {
                    rideEnded = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
                
                Button("Driver's Corner") {
                    showDriversCorner = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
        }
        .padding()
        .navigationDestination(isPresented: $rideEnded) {
            RideCompletedView(request: request)
        }
        .navigationDestination(isPresented: $showDriversCorner) {
            FetchUserView()
        }
    }
}
