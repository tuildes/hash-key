import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: SecureViewModel = SecureViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {

            // MARK: - Password
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .bottom, spacing: 8) {
                    Text("Senha gerada")
                        .font(.caption)
                        .foregroundColor(.appTextAlt)

                    Spacer()

                    ResetButton {
                        viewModel.generatePassword()
                    }
                }

                PasswordText(text: viewModel.password)
                    .frame(height: 120, alignment: .top)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        viewModel.copyPassword()
                    }
            }

            // MARK: - Password configuration
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(
                        "Comprimento da senha (\(String(format: "%0.f", viewModel.length)) caracteres)"
                    )
                    .font(.caption)
                    .foregroundColor(.appTextAlt)

                    Slider(value: $viewModel.length, in: 4...32, step: 1) {
                        Text("Length")
                    }
                }

                VStack {
                    HStack(spacing: 16) {
                        Toggle(isOn: $viewModel.includeLowercase) {
                            Text("Lowercase")
                                .font(.caption)
                                .foregroundColor(.appTextAlt)
                        }
                        Toggle(isOn: $viewModel.includeUppercase) {
                            Text("Uppercase")
                                .font(.caption)
                                .foregroundColor(.appTextAlt)
                        }
                    }

                    HStack(spacing: 16) {
                        Toggle(isOn: $viewModel.includeNumbers) {
                            Text("Numbers")
                                .font(.caption)
                                .foregroundColor(.appTextAlt)
                        }
                        Toggle(isOn: $viewModel.includeSymbols) {
                            Text("Symbols")
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
                            Text("Força da senha")
                                .font(.caption)

                            Spacer()

                            Text(viewModel.passwordStrength.title.uppercased())
                                .font(.body)
                                .bold()
                        }

                        ProgressView(value: viewModel.passwordStrength.rawValue)
                            .progressViewStyle(.linear)
                            .tint(.appBackground)

                        HStack {
                            VStack(alignment: .leading) {
                                Text("Entropia")
                                    .font(.caption)
                                    .foregroundColor(.appBackground)

                                Text(String(format: "%.1f bits", viewModel.entropy))
                            }
                            .frame(maxWidth: .infinity)

                            VStack(alignment: .leading) {
                                Text("Brute-force")
                                    .font(.caption)
                                    .foregroundColor(.appBackground)

                                Text(viewModel.bruteForceTime.readableCrackTime)
                            }
                            .frame(maxWidth: .infinity)

                            VStack(alignment: .leading) {
                                Text("Vazamentos")
                                    .font(.caption)
                                    .foregroundColor(.appBackground)

                                Text(viewModel.isLeaked ? "VAZADO" : "Nenhum")
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(16)
                    .foregroundColor(.appBackground)
                    .background(.tint)
                    .cornerRadius(4)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Hashes Criptográficos")
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
