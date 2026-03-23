import CryptoKit
import Foundation

final class Network {
    static func getPWNed(preffix: String) async throws -> Bool {
        guard let URL = URL(string: "https://api.pwnedpasswords.com/range/\(preffix)") else {
            throw SecureError.urlError
        }

        var request = URLRequest(url: URL)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = String(data: data, encoding: .utf8) ?? ""

        print(response)

        return false
    }
}
