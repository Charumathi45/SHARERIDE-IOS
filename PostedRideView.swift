// import SwiftUI

// struct PostedRideView: View {
//     @State private var passengerRequests: [PassengerRequest] = []
//     @State private var selectedPassengerRequest: PassengerRequest?
//     @State private var isLoading = true
//     @State private var errorMessage: String?
//     @State private var showRideConfirmationSheet = false
//     @State private var showSuccessMessage = true
//     @State private var navigateToOfferRide = false  // ✅ Navigation trigger

//     let pickupLocation: String
//     let dropoffLocation: String
//     let departureDate: String
//     let availableSeats: String
//     let carDetails: String
//     let seatPrice: String

//     var body: some View {
//         NavigationStack {
//             VStack {
//                 // ✅ Success message with delayed navigation
//                 if showSuccessMessage {
//                     Text("✅ Ride was posted successfully!")
//                         .foregroundColor(.green)
//                         .padding()
//                         .background(Color.green.opacity(0.1))
//                         .cornerRadius(10)
//                         .onAppear {
//                             DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                                 showSuccessMessage = false
//                                 navigateToOfferRide = true
//                             }
//                         }
//                 }

//                 if isLoading {
//                     ProgressView("Loading passenger requests...")
//                 } else if let error = errorMessage {
//                     Text("❌ \(error)")
//                         .foregroundColor(.red)
//                         .padding()
//                 } else {
//                     ScrollView {
//                         rideDetailsView

//                         Text("Passenger Requests")
//                             .font(.headline)
//                             .padding(.top)

//                         if passengerRequests.isEmpty {
//                             Text("No passenger requests found.")
//                                 .foregroundColor(.gray)
//                                 .padding()
//                         } else {
//                             ForEach(passengerRequests, id: \.id) { request in
//                                 PassengerRequestCard(
//                                     request: request,
//                                     onAccept: {
//                                         selectedPassengerRequest = request
//                                         showRideConfirmationSheet = true
//                                     },
//                                     passengerRequests: $passengerRequests
//                                 )
//                             }
//                         }
//                     }
//                     .padding()
//                 }

//                 // ✅ Hidden NavigationTrigger
//                 NavigationLink(
//                     destination: OfferRideView(),
//                     isActive: $navigateToOfferRide,
//                     label: { EmptyView() }
//                 )
//             }
//             .navigationBarTitleDisplayMode(.inline)
//             .navigationBarHidden(true)
//             .onAppear { fetchPassengerRequests() }
//         }
//         .sheet(isPresented: $showRideConfirmationSheet) {
//             if let request = selectedPassengerRequest {
//                 RideConfirmationView(
//                     pickupLocation: pickupLocation,
//                     dropoffLocation: dropoffLocation,
//                     departureDate: departureDate,
//                     availableSeats: availableSeats,
//                     carDetails: carDetails,
//                     seatPrice: seatPrice,
//                     passengerName: request.passengerName,
//                     seatsBooked: request.availableSeats
//                 )
//             }
//         }
//     }

//     // ✅ Ride info display
//     var rideDetailsView: some View {
//         VStack(alignment: .leading, spacing: 10) {
//             HStack {
//                 Image(systemName: "mappin.and.ellipse")
//                 Text("\(pickupLocation) → \(dropoffLocation)")
//             }
//             HStack {
//                 Image(systemName: "calendar")
//                 Text("Date: \(departureDate)")
//             }
//             HStack {
//                 Image(systemName: "person.3.fill")
//                 Text("\(availableSeats) seats available")
//             }
//             HStack {
//                 Image(systemName: "car.fill")
//                 Text(carDetails)
//             }
//             HStack {
//                 Image(systemName: "dollarsign.circle")
//                 Text("₹\(seatPrice) per seat")
//             }
//         }
//         .padding()
//         .background(Color(.systemGray6))
//         .cornerRadius(12)
//     }

//     // ✅ API call
//     func fetchPassengerRequests() {
//         guard let url = URL(string: "http://localhost/ShareRide/get_ride_request.php") else {
//             errorMessage = "Invalid URL"
//             isLoading = false
//             return
//         }

//         URLSession.shared.dataTask(with: url) { data, _, error in
//             DispatchQueue.main.async {
//                 isLoading = false

//                 if let error = error {
//                     errorMessage = "Error: \(error.localizedDescription)"
//                     return
//                 }

//                 guard let data = data else {
//                     errorMessage = "No data received"
//                     return
//                 }

//                 do {
//                     let decoded = try JSONDecoder().decode(PassengerRequestsResponse.self, from: data)
//                     self.passengerRequests = decoded.requests.filter {
//                         $0.pickupLocation.lowercased() == pickupLocation.lowercased() &&
//                         $0.dropLocation.lowercased() == dropoffLocation.lowercased() &&
//                         $0.departureDate == departureDate
//                     }
//                 } catch {
//                     errorMessage = "Failed to decode: \(error.localizedDescription)"
//                 }
//             }
//         }.resume()
//     }
// }

// // MARK: - PassengerRequestCard View

// struct PassengerRequestCard: View {
//     let request: PassengerRequest
//     var onAccept: () -> Void
//     @Binding var passengerRequests: [PassengerRequest]

//     @State private var showRejectAlert = false

//     var body: some View {
//         VStack(alignment: .leading, spacing: 10) {
//             Text(request.passengerName)
//                 .font(.headline)

//             Text("\(request.availableSeats) seat(s) requested")
//                 .font(.subheadline)

//             Text("Travel Time: \(request.travelTime)")

//             HStack {
//                 Button("Accept") {
//                     onAccept()
//                 }
//                 .frame(maxWidth: .infinity)
//                 .padding()
//                 .background(Color.green)
//                 .foregroundColor(.white)
//                 .cornerRadius(8)

//                 Button("Reject") {
//                     showRejectAlert = true
//                 }
//                 .frame(maxWidth: .infinity)
//                 .padding()
//                 .background(Color.red.opacity(0.1))
//                 .foregroundColor(.red)
//                 .cornerRadius(8)
//             }
//         }
//         .padding()
//         .background(Color(.secondarySystemBackground))
//         .cornerRadius(12)
//         .alert(isPresented: $showRejectAlert) {
//             Alert(
//                 title: Text("Reject Request"),
//                 message: Text("Are you sure you want to reject this request?"),
//                 primaryButton: .destructive(Text("Yes")) {
//                     if let index = passengerRequests.firstIndex(where: { $0.id == request.id }) {
//                         passengerRequests.remove(at: index)
//                     }
//                 },
//                 secondaryButton: .cancel()
//             )
//         }
//     }
// }

// // MARK: - Preview
// struct PostedRideView_Previews: PreviewProvider {
//     static var previews: some View {
//         PostedRideView(
//             pickupLocation: "Chennai",
//             dropoffLocation: "Bangalore",
//             departureDate: "2025-08-01",
//             availableSeats: "3",
//             carDetails: "Swift - TN09AB1234",
//             seatPrice: "500"
//         )
//     }
// }
