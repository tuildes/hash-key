import Foundation

extension Double {
    var readableCrackTime: String {
        print(String(format: "%.0fs", self))

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

            case ..<315_360_0000:
                return String(format: "%.0f anos", (self / 31_536_000))

            default:
                return "Séculos"
        }
    }
}
