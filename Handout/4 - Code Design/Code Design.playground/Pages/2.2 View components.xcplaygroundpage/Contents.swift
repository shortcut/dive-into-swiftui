//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 # View Components
 */

/*:
 If a component contains a subview, it's best to make it generic, and to use a `ViewBuilder` to allow maximum flexibility when building the view.
 */
struct FancyQuotedView<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "quote.opening")
                .unredacted() // added so we can redact the view, and not hide the quotes
            content
            Image(systemName: "quote.closing")
                .unredacted() // added so we can redact the view, and not hide the quotes
        }
    }
}

/*:
 If a component is going to be used multiple times with
 similar content, it can be useful to write convenience initializers.
 A great example of this is all of the for `Button` when the label is `Text`

 Because of the environment, you can often customize a view from outside of the wrapper view, so even if you want to set the font or other properties, you can still use the convenience initializers.
 */
extension FancyQuotedView where Content == Text {
    init(_ text: String) {
        content = Text(text)
    }

    init(_ localizedText: LocalizedStringKey) {
        content = Text(localizedText)
    }
}

struct ComponentsView: View {
    let string = "Test"
    let key = LocalizedStringKey("Localized")

    var body: some View {
        VStack {
            FancyQuotedView {
                Text("Test")
            }
            FancyQuotedView {
                Rectangle()
                    .frame(width: 200, height: 20)
            }
            FancyQuotedView(string)
                .font(.largeTitle)
            FancyQuotedView(key)
                .foregroundColor(.red)
            FancyQuotedView(key)
                .redacted(reason: .placeholder)
        }
    }
}

PlaygroundPage.current.setLiveView(ComponentsView().padding())

/*:
 Following the general rule about when to use which modifier types, this view doesn't affect the layout, so lets re-implement it as a ViewModifier based component.
 */

//: [Next](@next)
