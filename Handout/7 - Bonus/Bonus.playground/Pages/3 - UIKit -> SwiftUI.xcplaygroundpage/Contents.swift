//: [Previous](@previous)

/*: # Transitioning to SwiftUI
 
 Just as with navigation, there is no silver bullet for achieving this transition with zero cost, pain, frustration and things that might simply not play well together. But we can definitely sketch out some guidelines that can keep you on a paved path:
 
 - try to extract as much logic as possible _from_ the `UIViewControllers`. For now, we could not find a better pattern to fit in with `SwiftUI` better than `MVVM`. Move all that logic into the `ViewModel`;
 - even if you are not ready to move on to `SwiftUI` (because of min iOS target requirements), try to always have `SwiftUI` in mind and design your code so that is as compatible with `SwiftUI` as possible:

 1. use `@Published` properties in `ViewModels` so that `SwiftUI` will simply pick the changes up;
 2. reduce the reliance on `viewDidLoad` as there isn't really a good mapping into `SwiftUI`;
 3. as mentioned above, keep as much business logic/ navigation logic/ trigger logic in the `ViewModel` and the `UIViewController` as "clean" as possible;
 
 - you can start off with independent screen `Views` which can be mapped to `UIKit` through `UIHostingController`, which is a subclass of `UIViewController` and is basically a plug-and-play adaptor; as mentioned in `Chapter 5: Navigation`, we could not observe any performance issues with the inter-op.
 - `SwiftUI Font` and `Color` are well integrated with `UIKit` counterparts so you can keep your design system aligned between the two worlds;
 - as explained in `Chapter 5: Navigation`, the level of migration and compatibility is related to how structured your navigation framework is; when beginning to have multiple screens/ flows in `SwiftUI` it might become harder to manage without the proper navigation API in place. For more complex apps we recommend looking into structured navigation so that it plays well with both `UIKit` and `SwiftUI` setups.
 */

//: [Next](@next)
