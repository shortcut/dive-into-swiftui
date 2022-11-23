//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

//: ## Environment basics

/*:
Environment value are used extensively in SwiftUI to propagate values, view modifiers like `.font` and `.textCase` set environment values that are read further down the hierarchy. The `Environment` is set up so the closest value set to your view is the one that's read.
 */

struct BasicEnvironment: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Title")
                Text("Small caption")
                    .environment(\.font, .caption2)
                    .environment(\.textCase, .lowercase)
                Text("Another title")
                    .environment(\.textCase, nil)
            }
            .font(.title)
            Text("Body")
                .textCase(nil)
        }
        .font(.body)
        .textCase(.uppercase)
    }
}

PlaygroundPage.current.setLiveView(BasicEnvironment().padding())

//: [Next](@next)
