import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: SecureViewModel = SecureViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {

            // MARK: - Password
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .bottom, spacing: 16) {
                    Text(.passwordGeneratedTitle)
                        .font(.caption)
                        .foregroundColor(.appTextAlt)

                    Spacer()

                    Button {
                        viewModel.copyPassword()
                    } label: {
                        Text(.passwordActionCopy)
                    }

                    ResetButton {
                        viewModel.generatePassword()
                    }
                }

                PasswordText(text: viewModel.password)
                    .frame(height: 96, alignment: .top)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        viewModel.copyPassword()
                    }
            }

            // MARK: - Password configuration
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("password_length_label \(Int(viewModel.length)) characters_suffix")
                        .font(.caption)
                        .foregroundColor(.appTextAlt)

                    Slider(value: $viewModel.length, in: 4...48, step: 2) {
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
                    VStack(spacing: 16) {
                        HStack {
                            Text(.strengthTitle)
                                .font(.caption)

                            Spacer()

                            Text(viewModel.passwordStrength.title)
                                .font(.body)
                                .bold()
                        }

                        ProgressView(value: viewModel.passwordStrength.rawValue)
                            .progressViewStyle(.linear)
                            .tint(.appBackground)

                        HStack {
                            VStack {
                                Text(.bruteforceEntropy)
                                    .font(.caption)
                                    .foregroundColor(.appBackground)

                                Text(String(format: "%.1f bits", viewModel.entropy))
                            }
                            .frame(maxWidth: .infinity)

                            VStack {
                                Text(.bruteforceTitle)
                                    .font(.caption)
                                    .foregroundColor(.appBackground)

                                Text(viewModel.bruteForceTime.readableCrackTime)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(16)
                    .foregroundColor(.appBackground)
                    .background(.tint)
                    .cornerRadius(4)

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
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(32)
        .background(.appBackground)
        .tint(
            viewModel.isLeaked ? .appError : viewModel.passwordStrength.color
        )
        .animation(.default, value: viewModel.passwordStrength)
    }
}
