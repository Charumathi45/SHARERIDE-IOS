import SwiftUI

struct RideListView: View {
    @State private var selectedRequest: GetCarListData? = nil
    @State private var selectedDate = Date()
    @State private var filteredRideRequests: [GetCarListData] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    @State private var getCarListData: [GetCarListData] = []
    @State private var navigateRes: Bool = false
    
    var pickupLocation = ""
    var dropoffLocation = ""
    var date = ""
    
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
            
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    
                    // 🗓️ Date Picker
                    DatePicker("Select Date", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                        .onChange(of: selectedDate) {
                            filterRidesForSelectedDate()
                        }
                    
                    Text("\(formattedDate), \(filteredRideRequests.count) Requests Found")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    if isLoading {
                        ProgressView("Loading...")
                            .padding()
                    } else if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else if filteredRideRequests.isEmpty {
                        Text("No ride requests available for this date.")
                            .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(filteredRideRequests, id: \.id) { request in
                                    RideRequestCardView(
                                        request: request,
                                        onRemove: { removeRequest(withId: request.id) },
                                        onRespond: {
                                            navigateRes = true
                                            selectedRequest = request
                                        }
                                    )
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .onAppear {
            selectedDate = Date() // default to today
            fetchRideRequests()
        }
        .navigationDestination(isPresented: $navigateRes) {
            if let data = selectedRequest {
                RideBookingView(request: data)
            }
        }
    }
    
    // MARK: - Helpers
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: selectedDate)
    }
    
    private func fetchRideRequests() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDateString = formatter.string(from: selectedDate)
        
        let fromData: [String: Any] = [
            "pickup_location": pickupLocation,
            "drop_location": dropoffLocation,
            "departure_date": selectedDateString
        ]
        
        APIHandler.shared.postAPIValues(
            type: GetCarList.self,
            apiUrl: APIList.getriderequests,
            method: "POST",
            formData: fromData
        ) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let response):
                    if response.status == "success" {
                        getCarListData = response.requests
                        filterRidesForSelectedDate()
                    } else {
                        errorMessage = "Failed to load ride requests"
                    }
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func filterRidesForSelectedDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let selectedDateString = formatter.string(from: selectedDate)
        let today = Calendar.current.startOfDay(for: Date())
        
        filteredRideRequests = getCarListData.filter { request in
            guard let requestDate = formatter.date(from: request.departureDate) else {
                return false
            }
            
            return requestDate >= today &&
            request.departureDate == selectedDateString &&
            request.pickupLocation.lowercased() == pickupLocation.lowercased() &&
            request.dropLocation.lowercased() == dropoffLocation.lowercased()
        }
    }
    
    private func removeRequest(withId id: Int) {
        filteredRideRequests.removeAll { $0.id == id }
    }
}

// MARK: - Card View

struct RideRequestCardView: View {
    let request: GetCarListData
    let onRemove: () -> Void
    let onRespond: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading) {
                    Text(request.pickupLocation)
                        .bold()
                    Text("Pickup")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Rectangle()
                    .frame(width: 2, height: 40)
                    .foregroundColor(.purple)
                    .padding(.horizontal, 8)
                
                VStack(alignment: .leading) {
                    Text(request.dropLocation)
                        .bold()
                    Text("Dropoff")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(request.departureDate)
                        .font(.caption)
                }
            }
            
            HStack {
                Label("\(request.seatPrice) passenger(s)", systemImage: "person.3.fill")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            
            HStack(spacing: 10) {
                Spacer()
                
                Button(action: { onRespond() }) {
                    Text("Respond")
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.purple)
                        .cornerRadius(20)
                }
                
                Button(action: { onRemove() }) {
                    Text("Remove")
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.red)
                        .cornerRadius(20)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Preview

struct RideListView_Previews: PreviewProvider {
    static var previews: some View {
        RideListView(pickupLocation: "Chennai", dropoffLocation: "Bangalore")
    }
}
