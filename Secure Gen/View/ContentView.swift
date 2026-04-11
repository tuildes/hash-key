import SwiftUI
import StoreKit

struct ContentView: View {
    @StateObject private var viewModel: SecureViewModel = SecureViewModel()

    @Environment(\.requestReview) var requestReview
    @State private var showedReviewRequestInSession: Bool = false
    @State private var didCopy: Bool = false
    @State private var showLicense: Bool = false

    private func requestReviewInSession() {
        guard !showedReviewRequestInSession else { return }
        showedReviewRequestInSession = true
        requestReview()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {

            // MARK: - Password
            VStack(alignment: .center, spacing: 24) {

                HStack(alignment: .bottom) {
                    Text(.passwordGeneratedTitle)
                        .font(.caption)
                        .foregroundColor(.appTextAlt)

                    Spacer()

                    ResetButton {
                        viewModel.generatePassword()
                    }
                }

                VStack(spacing: 8) {
                    if (viewModel.includeLowercase || viewModel.includeSymbols
                        || viewModel.includeUppercase || viewModel.includeNumbers)
                    {
                        PasswordText(text: viewModel.password)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .onTapGesture {
                                viewModel.copyPassword()
                                requestReviewInSession()
                                withAnimation { didCopy = true }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation { didCopy = false }
                                }
                            }

                        Label(
                            didCopy ? .copied : .tapAction,
                            systemImage: didCopy ? "checkmark" : "doc.on.doc"
                        )
                        .foregroundColor(.appTextAlt)
                        .font(.caption)
                    } else {
                        Text(.noCharset)
                            .foregroundColor(.appText)
                    }
                }
                .frame(height: 120)

                // MARK: - Password feedback
                VStack(spacing: 12) {
                    HStack(spacing: 2) {
                        ForEach(0..<5) { i in
                            Rectangle()
                                .fill(
                                    i <= viewModel.passwordStrength.rawValue
                                        ? viewModel.passwordStrength.color
                                        : .appTextAlt.opacity(0.2)
                                )
                                .frame(height: 4)
                                .cornerRadius(2)
                        }
                    }
                    .accessibilityHidden(true)

                    HStack(alignment: .top, spacing: 16) {
                        VStack(alignment: .leading) {
                            Text(.bruteforceEntropy)
                                .font(.caption)
                                .foregroundColor(.appTextAlt)

                            Text(String(format: "%.1f bits", viewModel.entropy))
                                .font(.caption)
                                .foregroundColor(.appTextAlt)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        Text(viewModel.passwordStrength.title)
                            .font(.body)
                            .bold()
                            .foregroundStyle(.tint)

                        VStack(alignment: .trailing) {
                            Text(.bruteforceTitle)
                                .font(.caption)
                                .foregroundColor(.appTextAlt)

                            Text(viewModel.bruteForceTime.readableCrackTime)
                                .font(.caption)
                                .foregroundColor(.appTextAlt)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .frame(maxWidth: .infinity)
            }

            Divider()

            // MARK: - Password configuration
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("password_length_label \(Int(viewModel.length)) characters_suffix")
                        .font(.caption)
                        .foregroundColor(.appTextAlt)

                    Slider(value: $viewModel.length, in: 4...64, step: 2) {
                        Text("Length")
                    }
                }

                VStack {
                    HStack(spacing: 16) {
                        Toggle(isOn: $viewModel.includeLowercase) {
                            Text(.charsetLowercase)
                                .font(.caption)
                                .foregroundColor(.appTextAlt)
                        }
                        Toggle(isOn: $viewModel.includeUppercase) {
                            Text(.charsetUppercase)
                                .font(.caption)
                                .foregroundColor(.appTextAlt)
                        }
                    }

                    HStack(spacing: 16) {
                        Toggle(isOn: $viewModel.includeNumbers) {
                            Text(.charsetNumbers)
                                .font(.caption)
                                .foregroundColor(.appTextAlt)
                        }
                        Toggle(isOn: $viewModel.includeSymbols) {
                            Text(.charsetSymbols)
                                .font(.caption)
                                .foregroundColor(.appTextAlt)
                        }
                    }
                }
            }

            // MARK: - Password Analyzer
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {


                    VStack(alignment: .leading, spacing: 16) {
                        Text(.hashesTitle)
                            .font(.caption)
                            .foregroundColor(.appTextAlt)

                        ForEach(viewModel.hashes, id: \.id) { hash in
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(hash.name)
                                        .bold()

                                    Spacer()

                                    Text("\(hash.totalBits) bits")
                                        .font(.caption)
                                }

                                HashText(text: hash.value)
                            }
                        }
                    }

                    Button {
                        showLicense = true
                    } label: {
                        Text(.mitLicense)
                            .font(.caption)
                            .foregroundColor(.appTextAlt)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.top, 8)
                }
            }
            .scrollIndicators(.hidden)
            .sheet(isPresented: $showLicense) {
                NavigationStack {
                    LicenseView()
                }
            }
        }
        .padding(32)
        .background(.appBackground)
        .tint(
            viewModel.passwordStrength.color
        )
        .animation(.default, value: viewModel.passwordStrength)
    }
}
