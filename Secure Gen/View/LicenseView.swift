import SwiftUI

struct LicenseView: View {
    private let licenseText: String = {
        guard let url = Bundle.main.url(forResource: "LICENSE", withExtension: nil),
            let content = try? String(contentsOf: url, encoding: .utf8)
        else {
            return "License file not found."
        }
        return content
    }()

    var body: some View {
        ScrollView {
            Text(licenseText)
                .font(.caption)
                .foregroundColor(.appText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(32)
        }
        .scrollIndicators(.hidden)
        .background(.appBackground)
        .navigationTitle(.mitLicense)
        .navigationBarTitleDisplayMode(.inline)
    }
}
