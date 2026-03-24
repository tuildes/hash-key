import SwiftUI

struct RootView: View {
    @AppStorage("isFirstTime") private var isOnboardingActive: Bool = true

    var body: some View {
        if isOnboardingActive {
            OnboardingView {
                withAnimation(.easeInOut(duration: 0.4)) {
                    isOnboardingActive = false
                }
            }
            .transition(.opacity)
        } else {
            ContentView()
                .transition(.opacity)
        }
    }
}

#Preview {
    RootView()
}
