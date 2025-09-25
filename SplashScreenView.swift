import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var animateLogo = false
    @State private var animateText = false

    var body: some View {
        NavigationStack {
            ZStack {
                // ✨ Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.purple.opacity(0.95),
                        Color.purple,
                        Color.purple.opacity(0.85)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    // 🚗 Logo with pulse effect
                    Image(systemName: "car.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .scaleEffect(animateLogo ? 1.1 : 0.9)
                        .shadow(color: .white.opacity(0.6), radius: 20, x: 0, y: 0)
                        .animation(
                            .easeInOut(duration: 1.2).repeatForever(autoreverses: true),
                            value: animateLogo
                        )

                    // 🌟 App Title with left-to-right slide
                    Text("SHARERIDE")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .offset(x: animateText ? 0 : -UIScreen.main.bounds.width) // slide from left
                        .animation(.easeOut(duration: 1.0).delay(0.5), value: animateText)

                    // ✨ Tagline with left-to-right slide
                    Text("Your Journey, Shared")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                        .offset(x: animateText ? 0 : -UIScreen.main.bounds.width) // slide from left
                        .animation(.easeOut(duration: 1.2).delay(0.8), value: animateText)

                    Spacer()
                }
                .padding()
            }
            .onAppear {
                animateLogo = true
                animateText = true

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isActive = true
                }
            }
            .navigationDestination(isPresented: $isActive) {
                RidePreferenceView()
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SplashScreenView()
}
