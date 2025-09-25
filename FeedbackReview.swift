import SwiftUI

// MARK: - Feedback Model
struct Feedback: Identifiable {
    let id = UUID()
    let userName: String
    let comment: String
    let rating: Int
}

// MARK: - Feedback Data
let offerRideFeedbacks: [Feedback] = [
    Feedback(userName: "Charu", comment: "Driver was punctual and polite.", rating: 5),
    Feedback(userName: "Guna", comment: "Car was clean and comfortable.", rating: 4),
    Feedback(userName: "Sanjay", comment: "Very friendly and safe driver.", rating: 5),
    Feedback(userName: "Varshinie", comment: "Reached destination on time.", rating: 5),
    Feedback(userName: "Ravi", comment: "A bit of rash driving at times.", rating: 3),
    Feedback(userName: "Karthik", comment: "Smooth ride, very professional.", rating: 4),
    Feedback(userName: "Divya", comment: "Driver was helpful with luggage.", rating: 5),
    Feedback(userName: "Arun", comment: "Music was too loud, otherwise good.", rating: 3),
    Feedback(userName: "Sneha", comment: "Good conversation, enjoyable ride.", rating: 4),
    Feedback(userName: "Pravin", comment: "Air conditioning not working well.", rating: 3),
    Feedback(userName: "Meena", comment: "Driver drove safely and carefully.", rating: 5),
    Feedback(userName: "Harish", comment: "Very polite and respectful driver.", rating: 5),
    Feedback(userName: "Anitha", comment: "A bit late but safe driving.", rating: 4),
    Feedback(userName: "Suresh", comment: "Professional and courteous.", rating: 5),
    Feedback(userName: "Priya", comment: "Good driving skills, very safe.", rating: 4),
    Feedback(userName: "Vignesh", comment: "Driver was patient in traffic.", rating: 5),
    Feedback(userName: "Radha", comment: "Clean car and polite driver.", rating: 5),
    Feedback(userName: "Mohan", comment: "Smooth highway drive, no issues.", rating: 4),
    Feedback(userName: "Lakshmi", comment: "Slight delay, but good ride.", rating: 4),
    Feedback(userName: "Kiran", comment: "Excellent driving, highly recommended.", rating: 5)
]

let requestRideFeedbacks: [Feedback] = [
    Feedback(userName: "Aarav", comment: "Passenger was polite and respectful.", rating: 5),
    Feedback(userName: "Ishita", comment: "On time and cooperative.", rating: 5),
    Feedback(userName: "Rohan", comment: "Friendly passenger, good company.", rating: 4),
    Feedback(userName: "Neha", comment: "Talked a lot, but pleasant.", rating: 4),
    Feedback(userName: "Vikram", comment: "Late arrival at pickup point.", rating: 3),
    Feedback(userName: "Pooja", comment: "Paid promptly and was kind.", rating: 5),
    Feedback(userName: "Aditya", comment: "Very quiet and respectful.", rating: 4),
    Feedback(userName: "Snehal", comment: "Helped with navigation, very nice.", rating: 5),
    Feedback(userName: "Kunal", comment: "Polite but requested multiple stops.", rating: 3),
    Feedback(userName: "Megha", comment: "Friendly and easygoing passenger.", rating: 5),
    Feedback(userName: "Rahul", comment: "Clean and tidy, no issues.", rating: 4),
    Feedback(userName: "Simran", comment: "Respectful and cooperative.", rating: 5),
    Feedback(userName: "Naveen", comment: "Helpful and positive passenger.", rating: 5),
    Feedback(userName: "Tanya", comment: "Very punctual and nice.", rating: 4),
    Feedback(userName: "Siddharth", comment: "Passenger was cheerful and friendly.", rating: 5),
    Feedback(userName: "Kavya", comment: "Quiet but polite.", rating: 4),
    Feedback(userName: "Deepak", comment: "Cooperative and kind.", rating: 5),
    Feedback(userName: "Anjali", comment: "Slightly late but good passenger.", rating: 3),
    Feedback(userName: "Harsh", comment: "Passenger was very respectful.", rating: 5),
    Feedback(userName: "Ritika", comment: "Smooth experience, no issues.", rating: 4)
]

// MARK: - Reusable Feedback List
struct FeedbackListView: View {
    let title: String
    let feedbacks: [Feedback]
    
    var body: some View {
        ZStack {
            // Background gradient
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
            
            List(feedbacks) { feedback in
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(feedback.userName)
                            .font(.headline)
                        Spacer()
                        Text("⭐️ \(feedback.rating)/5")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    }
                    Text("“\(feedback.comment)”")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.9))
                        .shadow(radius: 3)
                )
                .padding(.vertical, 6)
            }
            .scrollContentBackground(.hidden) // so gradient shows behind list
            .navigationTitle(title)
        }
    }
}

// ✅ Unique names to avoid redeclaration
struct OfferRideFeedbackPage: View {
    var body: some View {
        FeedbackListView(title: "Offer Ride Feedback", feedbacks: offerRideFeedbacks)
    }
}

struct RequestRideFeedbackPage: View {
    var body: some View {
        FeedbackListView(title: "Request Ride Feedback", feedbacks: requestRideFeedbacks)
    }
}
