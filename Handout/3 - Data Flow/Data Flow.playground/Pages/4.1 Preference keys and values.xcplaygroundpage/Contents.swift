//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

//: ## Preference keys / values

/*:
 First we define a preference key, which implements a function that takes the current value, and a proposed value and can write the updated value to the current value.

 In this case, we're alway taking the highest value, and are only updating if there's a proposed value, and if the proposed value is greater than the current value.
 */
struct HighestPreferenceKey: PreferenceKey {
    static func reduce(value: inout Int?, nextValue: () -> Int?) {
        guard let proposed = nextValue() else { return }
        if proposed > (value ?? -.max) {
            value = proposed
        }
    }
}

/*:
 To track the preference key changes, you need to add `.onPreferenceChange` to a view, and then whenever a child of that view writes the preference key, the update closure will run and you can read that closure info your view.
 */
struct PreferenceKeyReader<Content: View>: View {
    @State private var value: Int?
    @ViewBuilder var content: Content

    var body: some View {
        HStack(alignment: .top) {
            label
                .fixedSize()
            VStack(alignment: .leading) {
                content
            }
            .onPreferenceChange(HighestPreferenceKey.self) { update in
                value = update
            }
        }
        .border(.secondary)
    }

    @ViewBuilder private var label: some View {
        if let value {
            Text("Read: \(value, format: IntegerFormatStyle())")
        } else {
            Text("Read: nil")
        }
    }
}

/*:
 To set a preference key, you add a `.preference(key:,value:)` modifier to the view, and the view will then send preference key updates up the view hierarchy.
 */
struct PreferenceKeySetter: View {
    let value: Int?

    init(_ value: Int?) {
        self.value = value
    }

    var body: some View {
        label
            .preference(key: HighestPreferenceKey.self,
                        value: value)
            .fixedSize()
    }

    @ViewBuilder private var label: some View {
        if let value {
            Text("Sent: \(value, format: IntegerFormatStyle())")
        } else {
            Text("Sent: nil")
        }
    }
}

struct CustomPreferenceKey: View {
    var body: some View {
        PreferenceKeyReader {
            PreferenceKeyReader {
                PreferenceKeySetter(-10)
            }
            firstStack
            PreferenceKeyReader {
                PreferenceKeyReader {
                    Text("Nothing")
                        .fixedSize()
                }
                secondStack
            }
        }
    }

    @ViewBuilder private var firstStack: some View {
        PreferenceKeySetter(1)
        PreferenceKeySetter(2)
        PreferenceKeySetter(9)
        PreferenceKeySetter(nil)
        PreferenceKeySetter(4)
    }

    @ViewBuilder private var secondStack: some View {
        PreferenceKeySetter(6)
        PreferenceKeySetter(8)
        PreferenceKeySetter(7)
    }
}

PlaygroundPage.current.setLiveView(CustomPreferenceKey().padding())

//: [Next](@next)
