import Combine
import CryptoKit

final class SecureViewModel: ObservableObject {

    // MARK: - Properties
    @Published public var password: String = ""

    @Published public var length: Int = 20
    @Published public var includeNumbers: Bool = true
    @Published public var includeSymbols: Bool = true
    @Published public var includeUppercase: Bool = true

    @Published public var error: SecureError? = nil
    @Published public var isLoading: Bool = false

    @Published public var isLeaked: Bool = false
    @Published public var entropy: Double = 0.0
    @Published public var bruteForceTime: Double = 0.0
    @Published private(set) var hashes: [HashName] = [
        HashName(name: "MD5", isObsolete: true, value: "", totalBits: 128),
        HashName(name: "SHA-1", isObsolete: true, value: "", totalBits: 160),
        HashName(name: "SHA-256", isObsolete: false, value: "", totalBits: 256),
        HashName(name: "SHA-384", isObsolete: false, value: "", totalBits: 384),
        HashName(name: "SHA-512", isObsolete: false, value: "", totalBits: 512),
    ]


    // MARK: - Initializer
    init() {}

    // MARK: - User actions
    public func generatePassword() {
        guard !password.isEmpty else {
            error = .invalidInput("Senha vazia")
            return
        }

        isLoading = true
        error = nil
        defer {
            isLoading = false
        }

        Task {
            await checkLeak()
        }
    }

    private func checkLeak() async {}
}
