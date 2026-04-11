import SwiftUI

struct ResetButton: View {
    @State private var isClicked: Bool = false
    var action: () -> Void

    var body: some View {
        if #available(iOS 26.0, *) {
            Button {
                action()
                withAnimation {
                    isClicked = true
                } completion: {
                    isClicked = false
                }
            } label: {
                Image(systemName: "arrow.circlepath")
                    .foregroundColor(.appText)
                    .background(.clear)
            }
            .symbolEffect(
                .drawOff.wholeSymbol,
                options: .nonRepeating,
                isActive: isClicked
            )
        }
    }
}
