//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 ## Implicit animations
 
 Implicit animations are the ones where you use `.animation(_:value:)` modifier to animate a particular view when a specified value changes.

 To use this modifier, place it after any other modifiers of your views, tell it what kind of animation you want, and also make sure you attach it to a particular value so the animation triggers only when that specific value changes.
 */

struct ImplicitAnimationExample1: View {
    @State private var isRotated = false

    var body: some View {
        Image(systemName: "hand.point.up.left")
            .font(.system(size: 60))
            .padding(.all, 50)
            .rotationEffect(isRotated ? .degrees( -30) : .degrees(50))
            .animation(.easeInOut, value: isRotated)
            .onTapGesture {
                isRotated.toggle()
            }
    }
}

PlaygroundPage.current.setLiveView(ImplicitAnimationExample1())

/*:
 Animation modifier will be applied to all its children elements. To avoid unwanted animations, do not apply it to parent containers.
 */

struct ImplicitAnimationExample2: View {
    @State private var isRotated = false

    var body: some View {
        HStack(spacing: 20) {
            thumbsUp
            thumbsDown
        }
        .animation(.easeInOut, value: isRotated)
        .onTapGesture {
            isRotated.toggle()
        }
    }
    
    var thumbsUp: some View {
        Image(systemName: "hand.thumbsup.fill")
            .font(.system(size: 60))
            .rotationEffect(isRotated ? .degrees( 180) : .degrees(0))
    }
    
    var thumbsDown: some View {
        Image(systemName: "hand.thumbsdown.fill")
            .font(.system(size: 60))
            .rotationEffect(isRotated ? .degrees( 180) : .degrees(0))
    }
}

PlaygroundPage.current.setLiveView(ImplicitAnimationExample2())


/*:
 The place and the order of animation is very important.
 
 If you apply multiple animation() modifiers, each one controls everything before it up to the next animation. This allows you to animate state changes in all sorts of different ways rather than uniformly for all properties.
 
 If animation is nil, the view doesn’t animate. That's how you disable animations.
 */

struct MultipleAnimationsExample: View {
    @State private var isHighlighted = false

    var body: some View {
        VStack {
            Rectangle()
                .fill(isHighlighted ? .blue : .mint)
                .animation(.linear(duration: 2), value: isHighlighted)
                .frame(width: 50, height: 50)
                .cornerRadius(isHighlighted ? 50 : 0)
                .animation(nil, value: isHighlighted)
                .onTapGesture {
                    isHighlighted.toggle()
                }
        }.frame(width: 100, height: 100)
    }
}

PlaygroundPage.current.setLiveView(MultipleAnimationsExample())

/*:
 You can animate changes caused by a binding being modified by adding animation() to your binding. If you want more control over the animation, you can pass parameters to animation() that affect how the transition happens.
 */

struct BindingAnimationExample: View {
    @State private var showingHomeControls = false

    var body: some View {
        VStack {
            Toggle("Show Home Controls", isOn: $showingHomeControls.animation())

            if showingHomeControls {
                Text("Include recommended controls for Home accessories and scenes")
            }
        }.frame(width: 200, height: 200)
    }
}

PlaygroundPage.current.setLiveView(BindingAnimationExample())

//: [Next](@next)
