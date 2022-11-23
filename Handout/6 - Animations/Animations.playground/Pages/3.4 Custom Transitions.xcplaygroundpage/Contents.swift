//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 ## Custom Transitions
 
 Although SwiftUI comes with a selection of transitions built in, it’s also possible to write entirely custom transitions. This functionality is made possible by the **.modifier** transition, which accepts any view modifier we want.
 
 The process takes three steps:

 1. Create a **ViewModifier** that represents your transition at any of its states.
 */

struct RotationEffectModifier: ViewModifier {
    let degrees: Double

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(degrees))
    }
}

/*:
 2. Create an **AnyTransition** extension that uses your view modifier for active and identity states.
 
 Modifier transition depends on two states: **active** and **identity**. Identity is applied when the view is fully inserted in the view hierarchy and active when the view is gone. During the transition, SwiftUI interpolates between these two states, and thus the type of active and identity modifier needs to be the same!
 */

extension AnyTransition {
    static var custom: AnyTransition {
        .modifier(
            active: RotationEffectModifier(degrees: -90),
            identity: RotationEffectModifier(degrees: 0)
        )
    }
}

/*:
 3. Apply that transition to your views using the **transition()** modifier.
 */

struct CustomTransition: View {
    @State private var isShowingRed = false

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.custom)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
}

PlaygroundPage.current.setLiveView(CustomTransition())

/*:
 Internally, both standard and custom transitions work in the same way. They need a modifier for the beginning and the end of the animation. SwiftUI will figure out the rest.
 */

//: [Next](@next)
