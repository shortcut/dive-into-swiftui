//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 ## Configuring an animation
 
 Once you create your animation instance, you can use the following modifiers to change the animation even more:
 
 1. `delay(_:)` - adds a delay of a specific amount of time before the animation starts.
 2. `repeatCount(_:autoreverses:)` - configures the animation to repeat a given number of times. If autoreverses is set, it plays the effect forwards and backwards instead of restarting the animation on each repeat.
 3. `repeatsForever(autoreverses:)` - like above, this modifier makes the animation repeat, but it repeats indefinitely instead of a given number of times.
 4. `speed(_)` - allows you to speed up or slow down the animation.
 
 Be careful when you combine these methods !!
 */


struct Animations: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 10) {
            delayedAnimation
            repeated5TimesAnimation
            repeatedForeverAnimation
            slowerAnimation
            combinedAnimation
            combinedAnimation2
        }
        .frame(width: 300, height: 700)
        .onAppear() {
            isAnimating.toggle()
        }
    }

    var delayedAnimation: some View {
        VStack {
            Text("Delayed Animation")
            Image(systemName: "suit.heart.fill")
                .scaleEffect(isAnimating ? 1.5 : 1)
                .font(.system(size: 40))
                .padding(.top, 10)
                .foregroundColor(isAnimating ? .red : .black)
                .animation(.linear(duration: 2).delay(3), value: isAnimating)
        }
    }
    
    var repeated5TimesAnimation: some View {
        VStack {
            Text("Repeated 5 times Animation")
            Image(systemName: "suit.heart.fill")
                .scaleEffect(isAnimating ? 1.5 : 1)
                .font(.system(size: 40))
                .padding(.top, 10)
                .animation(.easeInOut.repeatCount(5), value: isAnimating)
        }
    }
    
    var repeatedForeverAnimation: some View {
        VStack {
            Text("Repeated forever Animation")
            Image(systemName: "hand.point.up")
                .font(.system(size: 40))
                .rotationEffect(.degrees(isAnimating ? -45 : 45))
                .animation(.easeInOut.repeatForever(), value: isAnimating)
        }
    }
    
    var slowerAnimation: some View {
        VStack {
            Text("Slower Animation")
            Image(systemName: "hand.point.up")
                .font(.system(size: 40))
                .rotationEffect(.degrees(isAnimating ? -45 : 45))
                .animation(.easeInOut.repeatForever().speed(0.5), value: isAnimating)
        }
    }
    
    var combinedAnimation: some View {
        VStack {
            Text("Delayed and repeated forever Animation")
            Image(systemName: "hand.point.up")
                .font(.system(size: 40))
                .rotationEffect(.degrees(isAnimating ? -45 : 45))
                .animation(.easeInOut.delay(2).repeatForever(), value: isAnimating)
        }
    }
    var combinedAnimation2: some View {
        VStack {
            Text("Repeated forever and delayed Animation")
            Image(systemName: "hand.point.up")
                .font(.system(size: 40))
                .rotationEffect(.degrees(isAnimating ? -45 : 45))
                .animation(.easeInOut.repeatForever().delay(2), value: isAnimating)
        }
    }
}

PlaygroundPage.current.setLiveView(Animations())

//: [Next](@next)
