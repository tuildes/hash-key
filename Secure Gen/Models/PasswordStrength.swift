enum PasswordStrength {
    case veryWeak
    case weak
    case good
    case strong
    case veryStrong

    mutating func updateStrength(_ bitsEntropy: Double) throws {
        guard bitsEntropy >= 0 else {
            throw SecureError.invalidInput("Entropia invalida")
        }

        switch bitsEntropy {
            case 0..<28: self = .veryWeak
            case 28..<36: self = .weak
            case 36..<60: self = .good
            case 60..<128: self = .strong
            default: self = .veryStrong
        }
    }
}
