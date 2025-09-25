import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isNotificationsOn = true
    @State private var isDarkModeOn = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            // 🔹 Custom Navigation Bar
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                            .font(.body)
                    }
                }
                .foregroundColor(.purple)
                
                Spacer()
                
                Text("Settings")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
                
                Spacer().frame(width: 50) // keeps title centered
            }
            .padding()
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
            
            // 🔹 Settings Content
            ScrollView {
                VStack(spacing: 28) {
                    
                    // Account Section
                    SettingsSection(title: "Account") {
                        NavigationLink(destination: ResetPasswordView()) {
                            SettingsRow(icon: "lock.fill", title: "Change Password")
                        }
                        Button(action: {
                            showDeleteAlert = true
                        }) {
                            HStack {
                                Label("Delete Account", systemImage: "trash.fill")
                                    .foregroundColor(.red)
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                    
                    // Preferences Section
                    SettingsSection(title: "Preferences") {
                        Toggle(isOn: $isNotificationsOn) {
                            Label("Notifications", systemImage: "bell.fill")
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        
                        Toggle(isOn: $isDarkModeOn) {
                            Label("Dark Mode", systemImage: "moon.fill")
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onChange(of: isDarkModeOn) {
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let window = windowScene.windows.first {
                                window.overrideUserInterfaceStyle = isDarkModeOn ? .dark : .light
                            }
                        }
                    }
                    
                    // About Section
                    SettingsSection(title: "About") {
                        SettingsRow(icon: "info.circle.fill", title: "App Version 1.0.0")
                        SettingsRow(icon: "shield.fill", title: "Privacy Policy")
                        SettingsRow(icon: "doc.text.fill", title: "Terms of Service")
                    }
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete Account"),
                message: Text("Are you sure you want to permanently delete your account? This action cannot be undone."),
                primaryButton: .destructive(Text("Delete")) {
                    // 🔹 Handle delete account API call here
                },
                secondaryButton: .cancel()
            )
        }
    }
}

// 🔹 Reusable Section
struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            VStack(spacing: 1) {
                content
            }
        }
    }
}

// 🔹 Reusable Row
struct SettingsRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Label(title, systemImage: icon)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
