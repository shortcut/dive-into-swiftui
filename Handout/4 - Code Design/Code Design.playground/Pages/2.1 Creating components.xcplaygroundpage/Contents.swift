//: [Previous](@previous)

/*:
 # Creating Components

 > Component (noun)
 > 1. a constituent part; element; ingredient.
 > - from Dictionary.com

 When building views, it can be helpful for break a complex view into smaller elements. "Component" is a good way to describe this, as it implies smaller parts of a larger system.

 In general the difference between a full view and a component is that should have minimal state, and should be widely re-usable. Most of the views provided by the SwiftUI library are components.

 Depending on how the component should be used, there are two main ways to build components. The first is to create a `View` for the components, like `Text`, `Button` or `VStack`. The second is for use via `ViewModifier`, such as `.font` `.popover` or `.onTapGesture`. Which approach to use depends on what the component is used for, and how it interacts with the layout.

 As a general rule, `View` components are best used for things that affect the layout of the views, and `ViewModifier` based components are best used for manipulating the environment, presentation, and adding extra functionality to existing views.
 */

//: [Next](@next)
