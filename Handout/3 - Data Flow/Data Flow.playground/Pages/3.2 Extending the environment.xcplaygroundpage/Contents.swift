//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

//: ## Extending the environment

/*:
 Environment value are used extensively in SwiftUI to propagate values, view modifiers like `.font` and `.textCase` set environment values that are read further down the hierarchy. The `Environment` is set up so the closest value set to your view is the one that's read.
 */

//: First you have to define a new environment key that includes a default value
struct CustomValue: EnvironmentKey {
    static var defaultValue: Int? = nil
}

//: Then we extend `EnvironmentValues` to add the new key
extension EnvironmentValues {
    var customValue: Int? {
        get { self[CustomValue.self] }
        set { self[CustomValue.self] = newValue }
    }
}

//: Finally, as a convenience we can add a view modifier for setting the key
extension View {
    func customValue(_ customValue: Int?) -> some View {
        self.environment(\.customValue, customValue)
    }
}

//: To read the value, you use the `@Environment` property wrapper
struct CustomEnvironmentReader: View {
    @Environment(\.customValue) var value

    var body: some View {
        if let value {
            Text("\(value, format: IntegerFormatStyle())")
        } else {
            Text("No value")
        }
    }
}

struct CustomEnvironment: View {
    var body: some View {
        VStack(alignment: .leading) {
            CustomEnvironmentReader()
            Group {
                CustomEnvironmentReader()
                CustomEnvironmentReader()
                    .environment(\.customValue, 5)
            }
            .customValue(10)
        }
    }
}

PlaygroundPage.current.setLiveView(CustomEnvironment().padding())

//: [Next](@next)
