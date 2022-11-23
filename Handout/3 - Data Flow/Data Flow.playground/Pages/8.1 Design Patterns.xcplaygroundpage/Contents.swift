//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*: ## Design patterns

 We've established the various methods for moving data around, so lets talk about some things to keep in mind when deciding how to use these tools.

 ### View Models

 Depending on the complexity of your view, it may be useful to create view models to let you separate view layout code from other code.

 `Environment` and `EnvironmentObject` aren't the right place to inject dependencies into them, because the environment isn't available in 'init' for a `View`, it won't become available until the view is placed in the view tree. So dependencies for your view models need to injected some other way.

 ### Controlling updates

 Another important thing to keep in mind, is that every time a `Published` property on an `ObservableObject` changes, it will trigger an update of every `View` that references that object as a `ObservedObject`, `StateObject` or `EnvironmentObject`, so when creating an object that may be seen by many views, such as an `EnvironmentObject`, any value that changes often shouldn't be `Published`.

 To work around this, you can add functions that create `some Publisher<Output, Failure>` for those values, and then views that need to respond to those values can use `onReceive` to track that publisher and update the UI.
 */

//: [Next](@next)
