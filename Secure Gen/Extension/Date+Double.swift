import Foundation

extension Double {
    var readableCrackTime: String {
        switch self {
            case ..<1:
                return "Instantâneo"

            case ..<60:
                return String(format: "%.0fs", self)

            case ..<3_600:
                return String(format: "%.0f min", (self / 60))

            case ..<86_400:
                return String(format: "%.0f horas", (self / 3_600))

            case ..<31_536_000:
                return String(format: "%.0f dias", (self / 86_400))

            case ..<3_153_599_999:
                return String(format: "%.0f anos", (self / 31_536_000))

            case ..<31_536_000_000_000:
                return String(format: "%.0f séculos", (self / 3_153_600_000))

            default:
                return "+1000 Séculos"
        }
    }
}
