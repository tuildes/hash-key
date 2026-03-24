import Foundation

extension Double {
    var readableCrackTime: LocalizedStringResource {
        switch self {
            case ..<1:
                return .bruteforceInstant

            case ..<60:
                return "\(Int(self))s"

            case ..<3_600:
                return "\(Int(self / 60)) min"

            case ..<86_400:
                return "\(Int(self / 3_600)) bruteforce_hours"

            case ..<31_536_000:
                return "\(Int(self / 86_400)) bruteforce_days"

            case ..<3_153_600_000:
                return "\(Int(self / 31_536_000)) bruteforce_years"

            default:
                return .bruteforceCenturies
        }
    }
}
