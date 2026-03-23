import SwiftUI
enum PasswordStrength: Double {
    case veryWeak = 0.1
    case weak = 0.25
    case good = 0.5
    case strong = 0.75
    case veryStrong = 0.95

    var title: LocalizedStringResource {
        switch self {
            case .veryWeak: return .strengthVeryWeak
            case .weak: return .strengthWeak
            case .good: return .strengthFair
            case .strong: return .strengthStrong
            case .veryStrong: return .strengthVeryStrong
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
        switch bitsEntropy {
            case 0..<40: self = .veryWeak
            case 40..<60: self = .weak
            case 60..<80: self = .good
            case 80..<128: self = .strong
            default: self = .veryStrong
        }
    }
}
