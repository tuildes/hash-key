enum PasswordStrength {
    case veryWeak
    case weak
    case good
    case strong
    case veryStrong

    mutating func updateStrength(_ bitsEntropy: Double) {
        // guard bitsEntropy >= 0 else {
        //     throw SecureError.invalidInput("Entropia invalida")
        // }

        switch bitsEntropy {
            case 0..<40: self = .veryWeak
            case 40..<60: self = .weak
            case 60..<80: self = .good
            case 80..<128: self = .strong
            default: self = .veryStrong
        }
    }
}
