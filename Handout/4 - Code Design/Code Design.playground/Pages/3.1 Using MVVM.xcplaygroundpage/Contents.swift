//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 # Using MVVM
 */

/*:
 ![MVVM Diagram](MVVMPAttern.png)
 > Model–view–viewmodel (MVVM) is an architectural pattern in computer software that facilitates the separation of the development of the graphical user interface (GUI; the view)—be it via a markup language or GUI code—from the development of the business logic or back-end logic (the model) such that the view is not dependent upon any specific model platform.
 > -Wikipedia entry for MVVM

 The core idea of MVVM is to separate your "view" code from the other code in your app. This pattern became very useful in SwiftUI because it makes it easier to maintain previews, you can bind to the values in the view model with minimal effort, and there's not a strongly established pattern pushed by the Apple like MVC was for UIKit.

 We also can break MVVM in SwiftUI into "simple" and "complex", based on if the view model has internal state. A simple view model can be represented with a struct, whereas a complex view model needs to be represented with an ObservableObject.
 */

//: [Next](@next)
