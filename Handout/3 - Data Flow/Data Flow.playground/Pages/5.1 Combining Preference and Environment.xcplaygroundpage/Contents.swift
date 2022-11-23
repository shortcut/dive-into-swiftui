//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

//: ## Combining preferences and environment

/*:
 Now that we know how to send data up and down the view hierarchy, we can send information up and down the view stack.

 A basic example of this reading the width of all of the views in a column and using that to align the width of all of the views in a column.
 */

/*:
 First we need to create a preference key that passes the largest value above zero value up the view hierarchy.
 */
struct AlignedLabelWidthPreferenceKey: PreferenceKey {
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        guard let proposed = nextValue() else { return }
        if proposed > (value ?? 0) {
            value = proposed
        }
    }
}

// To set the preference key, we create
struct WidthReader<Key: PreferenceKey>: ViewModifier where Key.Value == CGFloat? {
    init(key: Key.Type) {}

    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: AlignedLabelWidthPreferenceKey.self, value: proxy.size.width)
                }
            }
    }
}

extension View {
    func widthReader<Key: PreferenceKey>(key: Key.Type = AlignedLabelWidthPreferenceKey) -> some View where Key.Value == CGFloat? {
        self.modifier(WidthReader(key: key))
    }
}

//: Then we need to define the environment key and add it to the EnvironmentValues
struct AlignedLabelWidthEnvironmentKey: EnvironmentKey {
    static var defaultValue: CGFloat? = nil
}

extension EnvironmentValues {
    var alignedLabelWidth: CGFloat? {
        get { self[AlignedLabelWidthEnvironmentKey.self] }
        set { self[AlignedLabelWidthEnvironmentKey.self] = newValue }
    }
}

/*:
 To match widths, we need to create a view that uses a `widthReader` to read the size of the view, and read the environment value and set that as the width of the leading label.
 */
struct HStackLabel: View {
    let label: String
    let detail: String

    @Environment(\.alignedLabelWidth) private var alignedWidth

    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .background {
                    Color.red.opacity(0.25)
                }
                .widthReader()
                .frame(width: alignedWidth, alignment: .leading)
                .background {
                    Color.red.opacity(0.25)
                }
            Text(detail)
                .background {
                    Color.blue.opacity(0.25)
                }
        }
    }
}

// Finally, we need to read the preference key and then inject that value into the environment.
struct AlignedLabelsView: View {
    @State private var labelWidth: CGFloat?

    var body: some View {
        VStack(alignment: .leading) {
            HStackLabel(label: "Label", detail: "Detail")
            HStackLabel(label: "Long Label", detail: "More Detail")
            HStackLabel(label: "Two\nLines", detail: "One line")
            HStackLabel(label: "One line", detail: "Two\nLines")
            HStackLabel(label: "L", detail: "D")
        }
        .onPreferenceChange(AlignedLabelWidthPreferenceKey.self) { update in
            labelWidth = update
        }
        .environment(\.alignedLabelWidth, labelWidth)
    }
}

PlaygroundPage.current.setLiveView(AlignedLabelsView().padding())

//: [Next](@next)
