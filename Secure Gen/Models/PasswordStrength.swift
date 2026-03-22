import SwiftUI
enum PasswordStrength: Double {
    case veryWeak = 0.1
    case weak = 0.25
    case good = 0.5
    case strong = 0.75
    case veryStrong = 0.95

    var title: String {
        switch self {
            case .veryWeak: return "Muito fraco"
            case .weak: return "Fraco"
            case .good: return "Bom"
            case .strong: return "Forte"
            case .veryStrong: return "Muito forte"
        }
    }

    var color: SwiftUI.Color {
        switch self {
            case .veryWeak: return .appError
            case .weak: return .appError
            case .good: return .appWarning
            case .strong: return .appSuccess
            case .veryStrong: return .appSuccess
        }
    }

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
