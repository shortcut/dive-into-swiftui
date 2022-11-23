//: [Previous](@previous)

/*:
 ## Transitions
 
 What we have discussed so far is animating a view that has been existed in the view hierarchy. We create animation to scale it up and down, rotate it or change its color or size.

 SwiftUI allows us to do more than that. You can define how a view is inserted or removed from the view hierarchy. In SwiftUI, this is known as transition. By default, the framework uses fade in and fade out transition, but we can change that by attaching a **transition()** modifier to a view.
 
 SwiftUI comes with several ready-to-use transitions such as slide, move, opacity, etc. We are allowed to develop our own or simply mix and match various types of transition together to create a desired transition.
 
 Note: Transitions only animate when the current transaction contains an animation.
 
 Note: If the body executes again, the view doesn't fade in again unless the condition in the if statement changes.
 */

//: [Next](@next)
