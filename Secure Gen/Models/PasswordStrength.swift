import SwiftUI
enum PasswordStrength: Int {
    case veryWeak = 0
    case weak = 1
    case good = 2
    case strong = 3
    case veryStrong = 4

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
            case .weak: return .appErrorAlt
            case .good: return .appWarning
            case .strong: return .appSuccessAlt
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
