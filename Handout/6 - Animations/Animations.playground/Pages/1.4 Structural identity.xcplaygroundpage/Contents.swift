//: [Previous](@previous)

/*:
  ## Structural identity
  
  As I said at the beginning, each view has its own identity, even if it's not explicit.
  
  SwiftUI uses the structure of your view hierarchy to generate implicit identities for your views so you don't have to. Based on their type and position you can distinguish them from each other.
  
  SwiftUI leverages structural identity throughout its API, and a classic example is when you use if statements or other conditional logic within your View code. The structure of the conditional statement gives you a clear way to identify each view.
  ```
  if condition {
     viewA
 } else {
     viewB
 }
  ```

  The first view only shows when the condition is true, while the second view only shows when the condition is false. That means we can always tell which view is which, even if they happen to look similarly. In fact, this is the key to understanding our first examples.
 
  The benefits of understanding view's identity:
  - Improves animations
  - help performance
 */

//: [Next](@next)
