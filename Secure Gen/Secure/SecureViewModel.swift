import Combine
import CryptoKit
import Foundation

final class SecureViewModel: ObservableObject {

    // MARK: - Properties
    @Published public var password: String = ""

    @Published public var length: Float = 32.0
    @Published public var includeNumbers: Bool = true
    @Published public var includeSymbols: Bool = true
    @Published public var includeUppercase: Bool = true
    @Published public var includeLowercase: Bool = true

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

    @Published public var passwordStrength: PasswordStrength = .veryWeak

    private var charset: [Character] {
        var c: [Character] = [Character]()
        c.reserveCapacity(94)

        // Default: Charset minusculo
        if includeLowercase {
            c.append(contentsOf: [
                "a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
                "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
                "u", "v", "w", "x", "y", "z",
            ])
        }

        if includeUppercase {
            c.append(contentsOf: [
                "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
                "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
                "U", "V", "W", "X", "Y", "Z",
            ])
        }
        if includeNumbers {
            c.append(contentsOf: [
                "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
            ])
        }
        if includeSymbols {
            c.append(contentsOf: [
                "!", "@", "#", "$", "%", "^", "&", "*", "(", ")",
                "-", "_", "=", "+", "[", "]", "{", "}", "|",
                ";", ":", "\"", ".", "/", "?", "~", " ", ",",
            ])
        }

        return c
    }

    // MARK: - Initializer
    init() {}

    // MARK: - User actions
    public func generatePassword() {
        guard
            self.includeNumbers || self.includeLowercase || self.includeUppercase
                || self.includeSymbols
        else {
            error = .invalidInput("Charset invalido")
            return
        }

        isLoading = true
        error = nil
        defer {
            isLoading = false
        }

        let length = Int(length)

        let randomBytes = PasswordService.generateRandomBytes(
            length, charsetCount: UInt8(self.charset.count)
        )

        self.entropy = PasswordService.calculateEntropy(length, totalCharacters: self.charset.count)
        self.bruteForceTime = PasswordService.estimateBruteForce(entropy)
        self.password = PasswordService.generatePassword(
            length, charset: self.charset,
            randomBytes: randomBytes
        )
        self.passwordStrength.updateStrength(entropy)

        computeHashs()
        Task {
            await checkLeak()
        }
    }

    // TODO: Check Leak
    private func checkLeak() async {}
    private func computeHashs() {}
}
