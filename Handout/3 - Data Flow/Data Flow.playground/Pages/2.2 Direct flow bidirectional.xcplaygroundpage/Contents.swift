//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

//: # Direct Flow

//: Bidirectional flow between child and parent

/*:
 If you want to be able to manipulate a value from within a child view, using a `Binding` allows you to safely change the value from either the parent or child.
 */

struct Child: View {
    @Binding var value: Int

    var body: some View {
        Button("Child increment") {
            value += 1
        }
    }
}

struct Parent: View {
    @State var value: Int = 0

    var body: some View {
        VStack {
            Text("\(value, format: IntegerFormatStyle())")
            Button("Parent increment") {
                value += 1
            }
            Child(value: $value)
        }
    }
}

PlaygroundPage.current.setLiveView(Parent().padding())

//: [Next](@next)
