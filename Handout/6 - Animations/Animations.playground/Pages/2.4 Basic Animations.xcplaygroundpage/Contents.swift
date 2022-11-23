//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 
 ## Basic animations
 
 We easily create an animation by adding the `animation(_)` modifier or the explicit function, `withAnimation`, but what is the value that you passed as the parameter?
 
 The framework already comes with a number of built-in animations to create different effects.
 
 1. **Default animation** - is a basic animation with 0.35 seconds duration and an ease-in-ease-out timing curve
 2. **Linear animation** - has a constant speed throughout the duration of the animation.
 3. **EaseIn animation** - starts out slow and speeds up at the end
 4. **EaseOut animation** - starts out fast and slows at the end
 5. **EaseInOut animation** - starts slow, speeds up, and then slows down again.
 6. **TimingCurve animation** - to specify your own control points. This is great if you want more control. By using the control points we specify how the animation will behave in any moment in time, from start to end based on Bézier Curve equations. Most of the predefined animations can be described by a timing curve animation.
 
 Note:  For more precise control to our animation, we can add duration. This allows our animation to last for the indicated time.
 */

struct BasicAnimationsExample1: View {
    @State private var angle: Double = 0
    @State private var isRotating: Bool = false

    var body: some View {
        VStack(spacing: 10) {
            defaultAnimation
            linearAnimation
            easeInAnimation
            easeOutAnimation
            easeInOutAnimation
            timingCurveAnimation
            Button("animate") {
                isRotating.toggle()
            }
        }
        .frame(width: 300, height: 700)
    }

    var defaultAnimation: some View {
        VStack {
            Text("Default Animation")
            Image(systemName: "applelogo")
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .animation(.default, value: isRotating)
        }
    }

    var linearAnimation: some View {
        VStack {
            Text("Linear Animation")
            Image(systemName: "applelogo")
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .animation(.linear(duration: 1), value: isRotating)
        }
    }

    var easeInAnimation: some View {
        VStack {
            Text("easeIn Animation")
            Image(systemName: "applelogo")
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .animation(.easeIn(duration: 1), value: isRotating)
        }
    }

    var easeOutAnimation: some View {
        VStack {
            Text("easeOut Animation")
            Image(systemName: "applelogo")
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .animation(.easeOut(duration: 1), value: isRotating)
        }
    }

    var easeInOutAnimation: some View {
        VStack {
            Text("easeInOut Animation")
            Image(systemName: "applelogo")
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .animation(.easeInOut(duration: 1), value: isRotating)
        }
    }

    var timingCurveAnimation: some View {
        VStack {
            Text("Timing Curve Animation")
            Image(systemName: "applelogo")
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .animation(.timingCurve(0.15, 1.62, 0.96, 0.03), value: isRotating)
        }
    }

}

PlaygroundPage.current.setLiveView(BasicAnimationsExample1())

//: [Next](@next)
