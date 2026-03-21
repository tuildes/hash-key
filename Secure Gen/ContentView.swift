import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: SecureViewModel = SecureViewModel()

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Senha gerada")
                        .font(.caption)

                    Spacer()

                    Button("Copiar") {}
                    Button {
                        viewModel.generatePassword()
                    } label: {
                        Image(systemName: "arrow.circlepath")
                    }
                }

                Text(viewModel.password)
                    .bold()
            }

            Spacer()

            Slider(value: $viewModel.length, in: 8...64, step: 4) {
                Text("Hello")
            } minimumValueLabel: {
                Text("8")
            } maximumValueLabel: {
                Text("64")
            }

            VStack {
                Toggle("Lowercase", isOn: $viewModel.includeLowercase)
                Toggle("Uppercase", isOn: $viewModel.includeUppercase)
                Toggle("Numbers", isOn: $viewModel.includeNumbers)
                Toggle("Symbols", isOn: $viewModel.includeSymbols)
            }

            Spacer()

            VStack {
                Text("Força: \(viewModel.passwordStrength)")
                Text("Entropia: \(viewModel.entropy.formatted(.number)) bits")
                // Text("Brute Force: \(viewModel.bruteForceTime))")
                Text("Vazamentos: NENHUM")
            }
        }
        .padding(32)
    }
}

#Preview {
    ContentView()
}
