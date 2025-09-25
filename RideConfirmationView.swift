import SwiftUI

struct RideConfirmationView: View {
    let pickupLocation: String
    let dropoffLocation: String
    let departureDate: String
    let availableSeats: String
    let carDetails: String
    let seatPrice: String
    let passengerName: String
    let seatsBooked: Int

    @State private var showRemoveConfirmation = false
    @State private var navigateToPostedRide = false
    @State private var showOTPVerify = false

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
        }
        VStack(spacing: 16) {
            ScrollView {
                VStack(spacing: 16) {
                    // Ride Info
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.purple)
                            VStack(alignment: .leading) {
                                Text("From").font(.caption).foregroundColor(.gray)
                                Text(pickupLocation).font(.body)
                            }
                        }

                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.purple)
                            VStack(alignment: .leading) {
                                Text("To").font(.caption).foregroundColor(.gray)
                                Text(dropoffLocation).font(.body)
                            }
                        }

                        HStack {
                            Image(systemName: "clock").foregroundColor(.purple)
                            Text(departureDate).font(.body)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Fare
                    HStack {
                        Text("Fare").foregroundColor(.gray)
                        Spacer()
                        Text("₹\(seatPrice)").fontWeight(.bold)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Passenger Info
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Confirmed Passenger").foregroundColor(.gray)
                            Text(passengerName).fontWeight(.semibold)
                            Text("\(seatsBooked) seat\(seatsBooked > 1 ? "s" : "") booked")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Actions
                    VStack(spacing: 20) {
                        Button {
                            showOTPVerify = true
                        } label: {
                            Text("Confirm the Ride")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.purple)
                                .cornerRadius(10)
                        }

                        Button {
                            showRemoveConfirmation = true
                        } label: {
                            HStack {
                                Image(systemName: "xmark.circle")
                                Text("Remove Passenger")
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 80)
            }

            Divider()
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "house")
                    Text("Home").font(.caption)
                }.foregroundColor(.gray)
                Spacer()
                VStack {
                    Image(systemName: "car.fill")
                    Text("Rides").font(.caption)
                }.foregroundColor(.purple)
                Spacer()
                VStack {
                    Image(systemName: "person")
                    Text("Profile").font(.caption)
                }.foregroundColor(.gray)
                Spacer()
            }
            .padding(.vertical, 10)
        }
        .edgesIgnoringSafeArea(.bottom)

        .alert(isPresented: $showRemoveConfirmation) {
            Alert(
                title: Text("Remove Passenger?"),
                message: Text("Are you sure you want to remove this passenger?"),
                primaryButton: .destructive(Text("Yes, Remove")) {
                    navigateToPostedRide = true
                },
                secondaryButton: .cancel()
            )
        }

        // ✅ Pass data to OTP view
        .sheet(isPresented: $showOTPVerify) {
            OTPVerifyView(
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
    RideConfirmationView(
        pickupLocation: "Chennai",
        dropoffLocation: "Bangalore",
        departureDate: "2025-08-01",
        availableSeats: "3",
        carDetails: "Swift - TN09AB1234",
        seatPrice: "500",
        passengerName: "John Smith",
        seatsBooked: 2
    )
}
