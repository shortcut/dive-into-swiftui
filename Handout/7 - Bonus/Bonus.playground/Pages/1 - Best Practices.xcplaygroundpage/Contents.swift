/*: # Best Practices in SwiftUI
 
 We've put together a list of practices that we have derived out of different situations but also some that we have found very interesting by various authors from the SwiftUI community. Some might have been covered in previous chapters, but this also serves as a sum up and an easier reference.
 
 1. The bedrock of SwiftUI are Components (covered in Chapter 4). We like to create a computed property for each _significant_ UI element/ group of UI elements. This not only helps with reusability in the eventuality in which we want to extract and reuse the element(s) in other `Views` but also gives some context as to what the component represents, improving readability.
 */

import SwiftUI

struct ArticleView: View {
	
	var data: [String] = []
	
	var body: some View {
		ScrollView {
			ForEach(data, id: \.self) { _ in
				/* ... */
				EmptyView()
			}
			promotionBanner
		}
		.overlay(alignment: .top) { listStickyHeader }
	}
	
	// MARK: - Components.
	
	/// Provides information about the reading progress of the article.
	private var listStickyHeader: some View {
		/* ... */
		EmptyView()
	}
	
	/// Further reductions on bundled articles.
	private var promotionBanner: some View {
		/* ... */
		EmptyView()
	}
}

/*:
 2. When trying to place elements in a `H/V/LazyH/LazyVStack`, it's preferred to use `.frame(maxWidth: .infinity, alignment:)` for horizontal and `.frame(maxHeight: .infinity, alignment:)` for vertical instead of adding `Spacer()`. `Spacer` is considered as another element in the stack and hence, while achieving the same effect as the `.frame` modifier, it will eat up more space as the `spacing` of the stack will be applied on both `leading` and `trailing` edges/ `top` and `bottom`.
 */

var spacerExample: some View {
	VStack(spacing: 12.0) {
		Text("Top label")
		// <- 12 spacing added here.
		Spacer()
		// <- 12 spacing added here.
		Text("Bottom label")
	}
}

var frameExample: some View {
	VStack(spacing: 12.0) {
		Text("Top label")
			.frame(maxHeight: .infinity, alignment: .top)
		// <- 12 spacing added here.
		Text("Bottom label")
	}
}

/*:
 3. Custom `inits` on `Views` should be avoided at all costs because of `SwiftUI` compiler wizardry. A concrete example is how `StateObject` init works together with `SwiftUI` in order to prevent it from being re-created at each `View` change:
 
`StateObject's` init looks something like:
 ```
 init(wrappedValue thunk: @autoclosure @escaping () -> ObjectType)
 ```
 Creating a `StateObject` with a reference to a variable/ constant instead of creating the wrapped value on the spot will invalidate the `SwiftUI` state mechanism.
 */

final class ViewModel: ObservableObject { }

// ❌ avoid this.
struct ContentView_NW: View {
	
	@StateObject var viewModel: ViewModel
	
	init(viewModel: ViewModel) {
		// ⁉️ Even if the ViewModel is marked with `@StateObject`, it will still be
		// re-created at each ContentView re-creation.
		self._viewModel = .init(wrappedValue: viewModel)
	}
	
	var body: some View {
		/* ... */
		EmptyView()
	}
}

// ✅ this can work if a custom init is really required.
struct ContentView_W: View {
	
	@StateObject var viewModel: ViewModel
	
	init(viewModel: @autoclosure @escaping () -> ViewModel) {
		// ✅ Because of the closure semantics, SwiftUI will properly handle the lifecycle
		// of the View <-> ViewModel relationship.
		self._viewModel = .init(wrappedValue: viewModel())
	}
	
	var body: some View {
		/* ... */
		EmptyView()
	}
}

/*:
 4. Define `styles` and `reusable code` using `ViewModifier`. One might think that an extension function on `View` can do the same thing, but the power of `ViewModifier` comes from its ability to store `State`, you can reference the `Environment` and `EnvironmentObjects` which makes it a powerful tool in the battle for consistency.
 
 5. Declare your view as `Equatable` to have more control over when and how your `View` should change: https://swiftwithmajid.com/2020/01/22/optimizing-views-in-swiftui-using-equatableview/.
 
 6. `AnyView` can prevent `SwiftUI` from properly determining when that `View` should be redrawn or not. Refrain from using `AnyView` unless there's no other way of circumventing the type erasure. Much of the redraws and `View identities` are derived from the type of the `Views`. `AnyView` erases that type, hence, making it less efficient/ hard to determine when a `View` should be redrawn or not.
 
 7. There are situations in which components require custom `Views` to be injected through closures. Avoid storing the escaping closure that computes the `View` instead of the `View` itself thinking that you're making a big efficiency impact. That's not the case and it can also lead to undefined behaviour. Read more at: https://rensbr.eu/blog/swiftui-escaping-closures/
 */

struct ContentView_Escaping<Decoration: View>: View {
	
	// ❌ don't do this.
	let decorationClosure: () -> Decoration
	
	// ✅ do this instead.
	let decoration: Decoration
	
	init(decorationClosure: @autoclosure () -> Decoration) {
		self.decoration = decorationClosure()
	}
	
	var body: some View {
		decoration
	}
}

/*:
 8. Replace `if { ... } else { ... }` clauses with failable initializers. `SwiftUI` will translate a `nil View` as if it isn't really as part of the hierarchy. This can make your code more streamlined and remove imbrications.
 
 9. Attach and de-attach listeners based on `.onAppear(perform:)` and `.onDisappear(perform:)` View modifiers. Not only is great for data load but it can also help with re-subscribing to some failed Combine streams.
 Furthermore, `.task(id:_:)` and `task(_:)` View modifiers allow you to perform `async` tasks correlated to the `.onAppear` and not only. The first modifier also allows you to perform certain tasks when the `id` parameter changes.
 
 10. Be mindful with the usage of `@Published` in `ObservableObjects` that are injected in the `Environment` as it can trigger unwanted re-renders of the `Views`.
 
 11. Do not set random `UUID` values to your models. This can prevent `SwiftUI` from properly performing identity checks and hence it limits the amount of goodies that you get out of the box. For more information about how to properly identify your models: https://developer.apple.com/documentation/swift/identifiable
 */

struct Model: Identifiable {
	
	let id = UUID()
	let name: String
}

// The two models will be different when used in SwiftUI views like: `ForEach`
// which derives the ids of the views based on the ids of the models which it iterates over.
let modelOne = Model(name: "Shortcut")
let modelTwo = Model(name: "Shortcut")

/*:
 
 12. Try to keep a reference to `async Tasks` so that they can be cancelled on demand. This is relevant and important if:
 - you do not want to allow long running/ expensive network calls to linger, even if `self` is weakly captured;
 - if your async work supports cancellation;
 */

final class SearchViewModel {
	
	/// e.g. even if we're debouncing the search request, the call itself might take longer
	/// than the next one. We want to cancel the previous one.
	private var searchTask: Task<Void, Never>? {
		didSet { oldValue?.cancel() }
	}
}

/*:
 
 13. Split your `Data` and `Domain` layers into separate `SwiftPackageManager` local packages. This removes the dependencies between whatever data layer APIs you might be using from actual business logic that should remain unchanged regardless of the former. The flexibility and the enforced separation of concerns will definitely pay off in the long run and will help you shape the way you think about data.
 
 e.g. data layer is using `Firebase's Firestore` for storing and reading data. Your `Domain` models should not know anything about that and the `Firebase` dependency shouldn't be "leaked" anywhere else in the project but the `Data package`.
 e.g. your data model can have all the properties `Optional` and you shouldn't care about custom decoding/ encoding of them. Upon mapping to `Domain` layer models then you can filter and apply any logic required for validating the models as opposed to failing early in the parsing and having to deal with custom decoding/ encoding.
 
 14. Do not store escaping closures in `Views` for custom, injected subviews. Instead store the result of computing that closure, if applicable. More details at: https://rensbr.eu/blog/swiftui-escaping-closures/
 
 e.g.
 ```swift
 struct CustomView<C: View>: View {
 
	// ❌ don't do this.
	let enricherBlock: () -> V
 
	// ✅ do this instead.
	let enricherValue: V
 
	var body: some View {
		...
	}
 }
 ```
 
 15. When setting the identity of a view, you must keep in mind that it must be UNIQUE and STABLE.
 
        - Stability improves performance and prevents unwanted transitions. Avoid storing the id in a computed property, `var id: UUID { UUID() }`.
        - Uniqueness helps us avoid undefined behaviours, especially in a list.
 
 16. To avoid unwanted animation, do not add animations to parent containers. Animation modifier will be applied to all its children elements.
 
 17. You can no longer disable animations in SwiftUI using the deprecated animation(nil). The suggestion is to use the `animation(_:value:)` modifier instead.
 
 18. To make combined transitions easier to use and re-use, you can create them as extensions on AnyTransition. For example, you could define a custom moveAndScale transition and try it out straight away:
 
 ```
 extension AnyTransition {
     static var moveAndScale: AnyTransition {
         AnyTransition.move(edge: .bottom).combined(with: .scale)
     }
 }
 ```
 
 19. Always split your “screen Views” into the `View` that embeds and has all the dependencies, `ViewModel` and the “content View” that only receives stateless data and blocks of code to execute when interacting with different `Buttons`, tap gestures or actions. This allows for better mocking, testability and loosens the dependencies as the blocks of code can be whatever fits the context and the data should not be bound to a certain component/ repository/ data layer.
 
 20. Dependency Management
 
 Since there are problems with just using `Environment` and `EnvironmentObject`, it means that we still need to think about dependency management, and what's the correct way to handle things.

 When possible, views should have as few dependencies as possible, ideally a model object, and closures that represent the various actions the view needs to perform. This is something that can be done for leaf views on the view tree, but isn't something that can be done for central nodes.

 Next you have to determine how to control the scope of your dependencies. Some dependencies can be truly app-wide, for instance if you set up a persistence layer at app launch, that's something that can be assumed to always exist. On the other hand, things like the current user can't be depended on until after the user has logged in. If you have a multi-window application, you may also want to make sure that parts of the dependency tree are different for each window.

 For app wide dependencies, you could use a singelton, but that makes it hard to inject data for previews or testing. You can also write something very similar to the `Environment` yourself that defines keys and default values, but allows you to overwrite those default values at run time.

 For scoped dependencies. you need to find the right way to inject them. There isn't 1 way to handle this, so the right option will vary by project. A very explicit way of handling this is [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture), and another pattern worth looking at is the [Factory Pattern](https://mokacoding.com/blog/swiftui-dependency-injection/).
 */

//: [Next](@next)
