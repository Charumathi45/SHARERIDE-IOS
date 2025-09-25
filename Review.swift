import SwiftUI

// MARK: - Review Model
struct Review: Identifiable {
    let id = UUID()
    let username: String
    let rating: Int
    let comment: String
    let date: String
}

// MARK: - Main Review View
struct ReviewView: View {
    @State private var reviews: [Review] = [
        Review(username: "Amit P.", rating: 5, comment: "Excellent faculty and infrastructure. Labs are top-notch!", date: "July 2025"),
        Review(username: "Riya S.", rating: 4, comment: "Hostel life is good, food is decent. Sports and clubs are active!", date: "June 2025"),
        Review(username: "Karthik M.", rating: 5, comment: "Amazing growth for a new IIT. The professors are very helpful.", date: "May 2025")
    ]
    
    @State private var showAddReview = false
    
    var body: some View {
        ZStack {
            // 🌈 Gradient Background (Purple + White Blend)
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
                List {
                    ForEach(reviews) { review in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(review.username)
                                    .font(.headline)
                                Spacer()
                                Text(review.date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack(spacing: 2) {
                                ForEach(0..<5) { index in
                                    Image(systemName: index < review.rating ? "star.fill" : "star")
                                        .foregroundColor(index < review.rating ? .yellow : .gray)
                                        .font(.caption)
                                }
                            }

                            Text(review.comment)
                                .font(.body)
                                .foregroundColor(.primary)
                                .padding(.top, 2)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden) // ✅ makes List blend with gradient

                Button(action: {
                    showAddReview = true
                }) {
                    Text("Write a Review")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(14)
                        .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle("Reviews")
        .sheet(isPresented: $showAddReview) {
            AddReviewView { newReview in
                reviews.insert(newReview, at: 0)
            }
        }
    }
}

// MARK: - Add Review View (Modal)
struct AddReviewView: View {
    @Environment(\.dismiss) var dismiss

    @State private var username = ""
    @State private var rating = 0
    @State private var comment = ""

    var onSubmit: (Review) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Your Name")) {
                    TextField("Enter your name", text: $username)
                }

                Section(header: Text("Rating")) {
                    HStack {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: rating >= star ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    rating = star
                                }
                        }
                    }
                }

                Section(header: Text("Your Review")) {
                    TextEditor(text: $comment)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Add Review")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Submit") {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MMMM yyyy"
                        let dateString = formatter.string(from: Date())
                        
                        let newReview = Review(
                            username: username.isEmpty ? "Anonymous" : username,
                            rating: rating,
                            comment: comment,
                            date: dateString
                        )
                        onSubmit(newReview)
                        dismiss()
                    }
                    .disabled(rating == 0 || comment.isEmpty)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ReviewView()
    }
}
