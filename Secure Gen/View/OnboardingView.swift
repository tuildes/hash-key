import SwiftUI

// MARK: - Data Modelxw
private struct OnboardingPage {
    let symbol: String
    let title: LocalizedStringResource
    let body: LocalizedStringResource
}

private let pages: [OnboardingPage] = [
    OnboardingPage(
        symbol: "lock.shield",
        title: .onboardingTitle1,
        body: .onboardingDescription1
    ),
    OnboardingPage(
        symbol: "barometer",
        title: .onboardingTitle2,
        body: .onboardingDescription2
    ),
    OnboardingPage(
        symbol: "number.square",
        title: .onboardingTitle3,
        body: .onboardingDescription3
    ),
]

// MARK: - Page View
private struct OnboardingPageView: View {
    let page: OnboardingPage
    let isLast: Bool
    let onGetStarted: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Image(systemName: page.symbol)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .foregroundColor(.appSuccess)
                .padding(.bottom, 48)

            Text(page.title)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.appText)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)

            Text(page.body)
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(.appText.opacity(0.7))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 32)

            Spacer()

            Group {
                if isLast {
                    Button(action: onGetStarted) {
                        Text(.getStarted)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .foregroundColor(.appBackground)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(.appSuccess)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                    .padding(.horizontal, 32)
                } else {
                    Color.clear
                        .frame(height: 54)
                }
            }
            .padding(.bottom, 80)
        }
    }
}

// MARK: - Onboarding View

struct OnboardingView: View {
    let onFinished: () -> Void

    @State private var currentPage = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.appBackground)
                .ignoresSafeArea()

            TabView(selection: $currentPage) {
                ForEach(pages.indices, id: \.self) { index in
                    OnboardingPageView(
                        page: pages[index],
                        isLast: index == pages.count - 1,
                        onGetStarted: onFinished
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            .tint(.appSuccess)
        }
    }
}
