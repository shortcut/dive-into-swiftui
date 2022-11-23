//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

//: # Direct Flow

//: ## Sending data blind from child to parent

/*:
 While this is possible, using a binding for this is cleaner unless there's a code complexity reason why the parent view can't know anything about the internals of the child view.
 */

struct Child: View {
    @State private var value: Int = 0
    let onUpdate: (Int) -> Void

    var body: some View {
        Button("Increment") {
            value += 1
            onUpdate(value)
        }.onAppear {
            onUpdate(value)
        }
    }
}

struct Parent: View {
    @State private var value: Int = 0

    var body: some View {
        VStack {
            Text("\(value, format: IntegerFormatStyle())")
            Child { update in
                value = update
            }
        }
    }
}

PlaygroundPage.current.setLiveView(Parent().padding())

//: [Next](@next)
