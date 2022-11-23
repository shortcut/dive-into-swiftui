//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 ## Built-in Transitions
 
 
### Identity
 - A transition that returns the input view, unmodified, as the output view.
 - Content should not animate.
 
### Opacity
 - A transition from transparent to opaque on insertion, and from opaque to transparent on removal.
 
 ### Scale
 - Transition enlarges a view when inserted and shrinks when removed.
 - You can customize the scale effect by specifying a scale parameter and anchor, the position from which the transition begins: `scale(scale: CGFloat, anchor: UnitPoint = .center)`
 
### Slide
 - A transition that inserts by moving in from the leading edge, and removes by moving out towards the trailing edge.
 
### Move(edge:)
 - The view slides in and out in the same specified direction.
 
### Offset
 - is similar to the move transition, except you have more control on the x and y position.
 */

struct BuiltInTransitions: View {
    @State private var showDetails = false

    var body: some View {
        VStack(spacing: 10) {
            Button("Show transitions") {
                withAnimation(.linear(duration: 2)) {
                    showDetails.toggle()
                }
            }.padding()

            if showDetails {
                Text("Identity")
                    .transition(.identity)
                Text("Opacity")
                    .transition(.opacity)
                Text("Scale")
                    .transition(.scale(scale: 0.3, anchor: .trailing))
                Text("Slide")
                    .transition(.slide)
                Text("Move")
                    .transition(.move(edge: .bottom))
                Text("Offset")
                    .transition(.offset(x:50, y:67))
            }
        }
        .frame(width: 300, height: 300, alignment: .top)
    }
}

PlaygroundPage.current.setLiveView(BuiltInTransitions())

//: [Next](@next)
