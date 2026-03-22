import CryptoKit
import Foundation

extension Digest {
    var hexString: String {
        self.map { String(format: "%02x", $0) }.joined()
    }
}
