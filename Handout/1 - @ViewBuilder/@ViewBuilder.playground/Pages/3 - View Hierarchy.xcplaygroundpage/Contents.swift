//: [Previous](@previous)
/*:
 ## View Tree/Hierarchy
 SwiftUI is a data-driven framework, meaning that views are a function of state, not a sequence of events ([WWDC 2019](https://www.youtube.com/watch?v=psL_5RIBqnY)). Meaning that a **`View`**, the building block of the framework, is bound to some data (state) as a source of truth, and automatically updates whenever the state changes. This is possible by defining views as functions that take in data-binding as an argument.

 This eliminates the view controller as a "middle man", resulting in having only one view hierarchy mainly composed of views.

 ### How does it work?

 As previously said, the **`View`** is the main UI element used to create the hierarchy. **`Body`** , it's computed property defines a **`View`**'s content, and it's, made of cild views.

 In order to render the parent view, all the child views will have to be rendered, same for the child view's child views, creating a recursion. The recursion breaks when a primitive view is rendered. A view is called primitive when it's body type is **`Never`** which is handled in a special way by the compiler.

 ```
 extension Text : View {
	public typealias Body = Never
 }

 extension Never : View {
	 public typealias Body = Never
	 public var body: Never { get }
 }
 ```
Here are some of the primitive types:
- **`Text`**
- **`Image`**
- **`Color`**
- **`Shape`**
- **`Spacer`**
- **`Divider`**
- **`List`**
 - etc.

 Every view has a state, a single source of truth, which can change during runtime. When the state changes, the body is requested again, recreating all the child views with it. Every small change in the data can cause multiple views to redraw (**`body`** computations) which can affects the app's performance. So it is important to be careful with how we manage our data changes, and how we update those states, not to run into performance issues.

 Luckily, SwiftUI helps a little, by detecting the changes and only redrawing the parts of the view which have been actually affected by a data update. This is done by using **AttributeGraph** which is an internal component used by SwiftUI to build and analyze the dependency graph for the data and its related views.

 We will get a closer look into some of the state types in later chapter, but until then here is a list with some of them:

 - **`@State`**
 - **`@StateObject`**
 - **`@Binding`**
 - **`@ObservedObject`**
 - **`@EnvironmentObject`**
 */
//: [Next](@next)
