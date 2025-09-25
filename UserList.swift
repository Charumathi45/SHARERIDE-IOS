import SwiftUI



struct UserListView: View {
    @State private var users: [User] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

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

            ScrollView {
                VStack(spacing: 15) {
                    if users.isEmpty && !isLoading {
                        Text("No users found.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(users) { user in
                            HStack {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.purple)
                                    .padding(.leading, 10)

                                VStack(alignment: .leading, spacing: 5) {
                                    Text(user.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text(user.email)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(15)
                            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 3)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .onAppear {
            fetchUsers()
        }
    }

    func fetchUsers() {
        guard let url = URL(string: APIList.getAllUsers) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                isLoading = false

                if let error = error {
                    errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else {
                    errorMessage = "No data received"
                    return
                }

                do {
                    let response = try JSONDecoder().decode(UserListResponse.self, from: data)
                    if response.status, let data = response.data {
                        users = data
                    } else {
                        errorMessage = "No users found"
                    }
                } catch {
                    errorMessage = "Failed to decode: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

#Preview {
    NavigationStack {
        UserListView()
    }
}
