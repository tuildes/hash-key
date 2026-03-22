import UIKit
import SwiftUI

struct PasswordText: UIViewRepresentable {
    let text: String

    func animateTextChange(for label: UILabel, newText: String) {
        let animation = CATransition()

        animation.duration = 0.5
        animation.type = CATransitionType.fade
        animation.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeInEaseOut)
        label.layer.add(animation, forKey: "changeTextTransition")

        label.text = newText
    }

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(.appText)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 3
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)

        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        if text != uiView.text {
            animateTextChange(for: uiView, newText: text)
        }
    }
}
