//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 # ViewModifier Components
 */

/*:
 The view modifier implementation is essentially the same, but it becomes generic over `Content` automatically, so we only need to implement the closure.
 */
struct FancyQuoted: ViewModifier {
    func body(content: Content) -> some View {
        HStack(spacing: 0) {
            Image(systemName: "quote.opening")
            content
            Image(systemName: "quote.closing")
        }
    }
}

//: For most ViewModifiers, it makes it easier to apply them if you add an extension to `View`
extension View {
    func withFancyQuotes() -> some View {
        self.modifier(FancyQuoted())
    }
}

struct ComponentsView: View {
    let string = "Test"
    let key = LocalizedStringKey("Localized")

    var body: some View {
        VStack {
            //: With a ViewModifier, it can be easier to reason about the environment before / after the modifier is applied.
            Text("Test")
                .font(.body)
                .withFancyQuotes()
                .font(.largeTitle)
            Rectangle()
                .frame(width: 200, height: 20)
                .withFancyQuotes()
            Text(string)
                .withFancyQuotes()
                .font(.largeTitle)
            Text(key)
                .foregroundColor(.red)
                .withFancyQuotes()
                .foregroundColor(.blue)
            Text(key)
                .redacted(reason: .placeholder)
                .withFancyQuotes()
        }
    }
}

PlaygroundPage.current.setLiveView(ComponentsView().padding())

/*:
 Following the general rule about when to use which modifier types, this view doesn't affect the layout, so lets re-implement it as a ViewModifier based component.
 */

//: [Next](@next)
