//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 ## Spring Animations
 
 Spring Animations are animations that move to their target point, overshoot a little, then bounce back.
 
 Types of Spring animations:
 
 1. `spring(response:dampingFraction:blendDuration:)` - If you just use .spring() by itself, with no parameters, you get a sensible default
 
 2. `interactiveSpring(response:dampingFraction:blendDuration:)`
 
 3. `interpolatingSpring(mass:stiffness:damping:initialVelocity:)`

 */

struct SpringDampingTypes: View {
    
    @State private var moving = false
    private let systemNameIcon: String = "cart.fill"

    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Text(".spring()")
                systemImage
                    .animation(.spring().repeatForever(), value: moving)
            }

            VStack(alignment: .center) {
                Text(".interactiveSpring()")
                systemImage
                    .animation(.interactiveSpring().repeatForever(), value: moving)
            }

            VStack(alignment: .center) {
                Text(".interpolatingSpring(stiffness: 1, damping: 0.5)")
                systemImage
                    .animation(.interpolatingSpring(stiffness: 1, damping: 0.5).repeatForever(), value: moving)
            }
            
            VStack(alignment: .center) {
                Text(".spring(dampingFraction: 0.0)")
                systemImage
                    .animation(.spring(dampingFraction: 0.0).repeatForever(), value: moving)
            }
        }
        .onAppear {
            moving.toggle()
        }
        .frame(width: 300)
    }
    
    var systemImage: some View {
        Image(systemName: systemNameIcon)
            .offset(x: moving ? 0 : 100)
    }
}

PlaygroundPage.current.setLiveView(SpringDampingTypes())

//: [Next](@next)
