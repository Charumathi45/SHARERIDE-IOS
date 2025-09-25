import SwiftUI

// MARK: - Fetch User View
struct FetchUserView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var userID: String = ""
    @State private var fetchedUser: DataClass?
    @State private var errorMessage: String?
    @State private var isLoading = false
    @State private var showReportSheet = false
    @State private var selectedReport: String? = nil
    @State private var showThankYou = false   // Navigation state
    @State private var reportTapCount = 0     // Track taps

    private let reportOptions = [
        "Nudity or sexual activity",
        "Hate speech or symbols",
        "Scam or fraud",
        "Violence or dangerous organisations",
        "Sale of illegal or regulated goods",
        "Bullying or harassment",
        "Pretending to be someone else",
        "Suicide, self-injury ",
        "The problem isn't listed here",
        "Report as unlawful"
    ]

    var body: some View {
        NavigationStack {
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
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Enter the current driver ID")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TextField("Enter driver ID", text: $userID)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)

                    Button(action: {
                        if fetchedUser != nil {
                            dismiss()
                        } else {
                            fetchUser()
                        }
                    }) {
                        Text(fetchedUser != nil ? "Close" : "Fetch User")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(fetchedUser != nil ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(userID.isEmpty || isLoading)

                    if isLoading { ProgressView() }

                    if let user = fetchedUser {
                        VStack(spacing: 8) {
                            Text("Name: \(user.name)")
                                .fontWeight(.semibold)
                            Text("Email: \(user.email)")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(8)

                        // Report button that needs 3 taps
                        Button(action: {
                            reportTapCount += 1
                            if reportTapCount == 3 {
                                showReportSheet = true
                                reportTapCount = 0 // reset after opening
                            }
                        }) {
                            Text("Report (\(reportTapCount)/3)")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(reportTapCount < 3 ? Color.orange : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .sheet(isPresented: $showReportSheet) {
                            ReportSheetView(user: user,
                                            options: reportOptions,
                                            onReportSelected: { reason in
                                                selectedReport = reason
                                                showReportSheet = false
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                    showThankYou = true
                                                }
                                            })
                        }
                    }

                    if let error = errorMessage {
                        Text(error).foregroundColor(.red)
                    }

                    Spacer()

                    // Navigation to Thank You page
                    if let reason = selectedReport, let user = fetchedUser {
                        NavigationLink(
                            destination: ThankYouView(driverName: user.name, reason: reason),
                            isActive: $showThankYou,
                            label: { EmptyView() }
                        )
                    }
                }
                .padding()
            }
        }
    }

    private func fetchUser() {
        guard !userID.isEmpty else { return }
        guard let url = URL(string: APIList.fetchUser) else { return }

        isLoading = true
        errorMessage = nil
        fetchedUser = nil

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "id=\(userID)".data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async { isLoading = false }

            if let error = error {
                DispatchQueue.main.async { errorMessage = "Error: \(error.localizedDescription)" }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { errorMessage = "No data received." }
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(FetchUserResponse.self, from: data)
                DispatchQueue.main.async {
                    if decodedResponse.success {
                        fetchedUser = decodedResponse.data
                    } else {
                        errorMessage = decodedResponse.message
                    }
                }
            } catch {
                DispatchQueue.main.async { errorMessage = "Failed to decode response: \(error.localizedDescription)" }
            }
        }.resume()
    }
}

// MARK: - Report Sheet
struct ReportSheetView: View {
    var user: DataClass
    var options: [String]
    var onReportSelected: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var customIssue: String = ""
    @State private var isOtherSelected = false

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
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            NavigationStack {
                VStack {
                    List {
                        ForEach(options, id: \.self) { option in
                            Button(option) {
                                if option == "The problem isn't listed here" {
                                    isOtherSelected = true
                                } else {
                                    onReportSelected(option)
                                    dismiss()
                                    print("Reported \(user.name) for: \(option)")
                                }
                            }
                        }

                        if isOtherSelected {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Describe your issue:")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                TextEditor(text: $customIssue)
                                    .frame(height: 100)
                                    .padding(8)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)

                                Button("Submit") {
                                    if !customIssue.trimmingCharacters(in: .whitespaces).isEmpty {
                                        onReportSelected(customIssue)
                                        dismiss()
                                        print("Reported \(user.name) for custom issue: \(customIssue)")
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            .padding(.vertical)
                        }
                    }
                }
                .navigationTitle("Select a problem to report")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                }
            }
        }
    }
}

// MARK: - Thank You Page
// MARK: - Thank You Page
struct ThankYouView: View {
    var driverName: String
    var reason: String
    @Environment(\.dismiss) private var dismiss   // to auto close

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
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green)

                Text("Thank You!")
                    .font(.title)
                    .fontWeight(.bold)

                Text("You have reported \(driverName) for:\n\"\(reason)\"")
                    .multilineTextAlignment(.center)
                    .padding()

                Text("Your problem will be sorted out soon.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                Spacer()
            }
            .padding()
        }
        .onAppear {
            // Auto dismiss after 5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                dismiss()
            }
        }
    }
}


// MARK: - Preview
struct FetchUserView_Previews: PreviewProvider {
    static var previews: some View {
        FetchUserView()
    }
}
