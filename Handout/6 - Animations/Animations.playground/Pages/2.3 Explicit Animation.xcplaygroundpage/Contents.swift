//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 ## Explicit animations
 
 With explicit animations there is no need to attach the animation modifier to the view, instead we have to wrap our changes inside a call to the `withAnimation(_:_:)` function.
 
 `withAnimation()` takes a parameter specifying the kind of animation you want. Then simply pass in the things you’d like to animate and SwiftUI will make sure your views move smoothly from one state to another.
 
 Explicit animations are often helpful because they cause every affected view to animate, not just those that have implicit animations attached.
 
 Note 1: Explicit animations do not override implicit animations!
 
 Note 2: Only the parameter values changed inside the braces will be animated.
 */

struct ExplicitAnimationExample: View {
    @State private var isRotating = false
    @State private var isHidden = false

    var body: some View {
        VStack(spacing: 14) {
            Rectangle() // top
                .frame(width: 64, height: 10)
                .cornerRadius(4)
                .rotationEffect(.degrees(isRotating ? 48 : 0), anchor: .leading)
            
            Rectangle() // middle
                .frame(width: 64, height: 10)
                .cornerRadius(4)
                .scaleEffect(isHidden ? 0.01 : 1, anchor: isHidden ? .trailing: .leading)
                .opacity(isHidden ? 0 : 1)
//                .animation(.linear(duration: 2), value: isHidden)
            
            Rectangle() // bottom
                .frame(width: 64, height: 10)
                .cornerRadius(4)
                .rotationEffect(.degrees(isRotating ? -48 : 0), anchor: .leading)
        }
        .frame(width: 300, height: 300)
        .onTapGesture {
            withAnimation(.interactiveSpring()){
                isRotating.toggle()
                isHidden.toggle()
            }
        }
    }
}

PlaygroundPage.current.setLiveView(ExplicitAnimationExample())

//: [Next](@next)
