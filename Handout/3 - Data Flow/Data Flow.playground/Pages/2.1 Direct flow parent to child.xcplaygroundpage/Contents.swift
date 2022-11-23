//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

//: # Direct Flow

//: ## Sending data from child to parent

/*:
 If the child view doesn't need to update the value at all, you can just define the value as a `let` and every time the value changes in the parent, it will update the child view.
 */

struct Child: View {
    let value: Int

    var body: some View {
        Text("\(value, format: IntegerFormatStyle())")
    }
}

struct Parent: View {
    @State private var value: Int = 0

    var body: some View {
        VStack {
            Button("Increment") {
                value += 1
            }
            Child(value: value)
        }
    }
}

PlaygroundPage.current.setLiveView(Parent().padding())

//: [Next](@next)
