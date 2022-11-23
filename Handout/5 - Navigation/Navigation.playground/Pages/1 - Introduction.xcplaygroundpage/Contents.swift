//: # Navigation in SwiftUI

/*:
I consider navigation to be one of the most overlooked aspects in most applications, and for good reason because Apple is barely starting to come up with concrete examples and patterns for how to deal with navigation in a scalable and type-safe way.
 
 Let's take a small stroll down memory lane just so we see how far we've gotten:
 
 ## Segue and Storyboards ~ UIKit
 Powerful and if configured properly allowed you not to have to think of navigation handling structure, navigation scope: it even worked cross Storyboards and even across Modules/ Projects, unwind segues etc. Its biggest caveats were the lack of type safety, the lack of proper compile time checking and the very tedious APIs that you had to implement if you wanted to perform the navigation. The nature of `MVC` told you that you had to both know the concrete place you were navigation _to_ from a `UIViewController` but you also had to know what that destination would expect and how to be configured. In a large team working on multiple `Storyboards` that translates to hell: a lot of friction points and loose contracts. And we haven't even touched on the fact that every `Identifier`/ `Storyboard name`/ `Segue` was referenced using a `String`. What can go wrong there?
 The attempt at fixing it came pretty recently with the addition of `@IBSegueAction` which allows you to `init` the destination `UIViewController` so that we get rid of the optionality properties. And while there are a lot of great articles out there about how you can make `Segues` more safe, it simply did not stick with anybody. People demanded more structure.
 
 ## Programatic Navigation ~ UIKit
 The explicit, programatic Navigation is what people resorted to because it mainly fixed `Segues`: no more `Strings` to reference `Storyboards`/ destinations, concrete APIs for instantiating the destination (we all know the need for having some properties `Optional` in the `UIViewController` because with `Segues` you could get a hold of the reference *only* after it has been initialized), but the transition from `Segue`, without Apple's official "endorsement", simply let people wondering and wandering _how_ this should be done: from the `UIViewController`, from a `UINavigationController` subclass, from the `ViewModel` (who used `ViewModels` back then?!) etc. So this translated into just replacing the segue code with programatic navigation: `navigationController?.push(Destination(), animated: true)`.
 This is when and where the most famous Navigation pattern was born: the `Coordinator pattern`. You could interface each flow with a `Coordinator` and have it concerned with `scoped` navigation. So the much missing `structure` came about and came strong: we went from nothing to `childCoordinators` and their lifecycle, cross `Coordinator` communication and so on.

 ## Declarative Navigation ~ SwiftUI
 The transition from all the above to this has been weird for everybody. So don't feel bad for having mixed feelings/ feeling weird about it.
 `SwiftUI`, in its declarative nature, sees everything as a function of state. With this in mind, we could understand the angle that the early `SwiftUI` navigation came from. You should be able to define, at any given point in time, your app as a `state`. That includes `Navigation` as well. As counter-intuitive this might seem, the simple fact that you are on the `Details page` is a new `state` of your app. So you should have no problems, given the tools, to write this in `SwiftUI` code, at least in theory.
 While `NavigationView` and the limited API of `NavigationLink` were simple and powerful enough in the earlier versions of SwiftUI, they were not scalable and fit for more complex navigation patterns and applications out there, not to mention the different behaviors between SwiftUI versions.
 The latest additions: `NavigationStack`, `NavigationSplitView` and `NavigationPath` have paved the way to better future of declarative, structured navigation and this is what we will explore more in hope of shedding more light down navigation alley.
*/

//: [Next](@next)
