//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport
/*:
 ## Combining and configuring transitions
 
 You are not limited to only use the built-in transitions. SwiftUI provides a few options to combine and configure these transitions.

 ### Asymmetric Transition

 An asymmetric transition lets you specify different transitions for insertion and removal of views.
 
 */

struct AsymmetricTransition: View {
    @State private var showDetails = false

    var body: some View {
        VStack(spacing: 10) {
            Button("Show transition") {
                withAnimation() {
                    showDetails.toggle()
                }
            }.padding()

            if showDetails {
                Rectangle()
                    .fill(.purple)
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                    .transition(.asymmetric(insertion: .scale, removal: .move(edge: .bottom)))
            }
        }
        .frame(width: 300, height: 300, alignment: .top)
    }
}

PlaygroundPage.current.setLiveView(AsymmetricTransition())

/*:
 ### Combining Transitions
 If you need to apply more than one effect during the transition, you can combine them. 
 You can combine two transitions using .combine(with:) method that returns a new transition that is the result of both transitions being applied.
 
 To make combined transitions easier to use and re-use, you can create them as extensions on AnyTransition. For example, you could define a custom moveAndScale transition and try it out straight away:
 */

extension AnyTransition {
    static var moveAndScale: AnyTransition {
        AnyTransition.move(edge: .bottom).combined(with: .scale)
    }
}

struct CombinedTransitions: View {
    @State private var showDetails = false

    var body: some View {
        VStack(spacing: 10) {
            Button("Show transition") {
                withAnimation() {
                    showDetails.toggle()
                }
            }.padding()

            if showDetails {
                Rectangle()
                    .fill(.purple)
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                    .transition(.moveAndScale)
            }
        }
        .frame(width: 300, height: 300, alignment: .top)
    }
}

PlaygroundPage.current.setLiveView(CombinedTransitions())

/*:
 
 ### Animating Transitions
 
 One more thing you can do, is attaching an animation to the transition, using `.animation(_:)`.
 */

struct AnimatedTransition: View {
    @State private var showDetails = false

    var body: some View {
        VStack(spacing: 10) {
            Button("Show transition") {
                withAnimation() {
                    showDetails.toggle()
                }
            }.padding()

            if showDetails {
                Rectangle()
                    .fill(.purple)
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                    .transition(.scale.animation(.easeIn))
            }
        }
        .frame(width: 300, height: 300, alignment: .top)
    }
}

PlaygroundPage.current.setLiveView(AnimatedTransition())

//: [Next](@next)
