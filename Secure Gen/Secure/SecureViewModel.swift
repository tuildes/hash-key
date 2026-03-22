import Combine
import Foundation
import UIKit.UIPasteboard
import CryptoKit

final class SecureViewModel: ObservableObject {

    // MARK: - Properties
    @Published public var password: String = ""

    @Published public var length: Float = 24.0 {
        didSet {
            generatePassword()
        }
    }
    @Published public var includeNumbers: Bool = true {
        didSet {
            generatePassword()
        }
    }
    @Published public var includeSymbols: Bool = false {
        didSet {
            generatePassword()
        }
    }
    @Published public var includeUppercase: Bool = true {
        didSet {
            generatePassword()
        }
    }
    @Published public var includeLowercase: Bool = true {
        didSet {
            generatePassword()
        }
    }

    @Published public var error: SecureError? = nil
    @Published public var isLoading: Bool = false

    @Published public var passwordStrength: PasswordStrength = .veryWeak
    @Published public var isLeaked: Bool = false
    @Published public var entropy: Double = 0.0
    @Published public var bruteForceTime: Double = 0.0
    @Published private(set) var hashes: [HashName] = [
        HashName(name: "MD5", isObsolete: true, value: "F1FF11FF11FF1F1F1", totalBits: 128),
        HashName(name: "SHA-1", isObsolete: true, value: "", totalBits: 160),
        HashName(name: "SHA-256", isObsolete: false, value: "", totalBits: 256),
        HashName(name: "SHA-384", isObsolete: false, value: "", totalBits: 384),
        HashName(name: "SHA-512", isObsolete: false, value: "", totalBits: 512),
    ]

    private var debounceWorkItem: DispatchWorkItem?

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
                "-", "_", "=", "+", ".", "?", "~", ",",
            ])
        }

        return c
    }

    // MARK: - Initializer
    init() {
        generatePassword()
    }

    // MARK: - User actions
    public func copyPassword() {
        UIPasteboard.general.string = self.password
    }

    public func generatePassword() {
        guard
            self.includeNumbers || self.includeLowercase || self.includeUppercase
                || self.includeSymbols
        else {
            error = .invalidInput("Charset invalido")
            return
        }

        debounceWorkItem?.cancel()

        isLoading = true
        error = nil

        let length = Int(length)

        let randomBytes = PasswordService.generateRandomBytes(
            length, charsetCount: UInt8(self.charset.count)
        )

        self.entropy = PasswordService.calculateEntropy(length, totalCharacters: self.charset.count)
        self.bruteForceTime = PasswordService.estimateBruteForce(entropy)
        self.password = PasswordService.generatePassword(
            length,
            charset: self.charset,
            randomBytes: randomBytes
        )
        self.passwordStrength.updateStrength(entropy)

        let workItem = DispatchWorkItem { [weak self] in
            Task {
                self?.computeHashs()
                await self?.checkLeak()
                self?.isLoading = false
            }
        }

        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: workItem)
    }

    private func checkLeak() async {}

    private func computeHashs() {
        let data = Data(self.password.utf8)

        self.hashes[0].value = Insecure.MD5.hash(data: data).hexString
        self.hashes[1].value = Insecure.SHA1.hash(data: data).hexString
        self.hashes[2].value = SHA256.hash(data: data).hexString
        self.hashes[3].value = SHA384.hash(data: data).hexString
        self.hashes[4].value = SHA512.hash(data: data).hexString
    }
}
