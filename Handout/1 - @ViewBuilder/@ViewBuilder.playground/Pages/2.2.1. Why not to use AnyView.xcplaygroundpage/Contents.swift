//: [Previous](@previous)
/*: # Application
## Why not to use AnyView
 Generics and having multiple return types in the same code block can be also solved by wrapping the views in `AnyView`, erasing their type and pleasing the compiler.\
 While this is not wrong, is not advised either because SwiftUI uses a type-based algorithm to determine when a given view should be redrawn on screen, and since two AnyView-wrapped views will always look completely identical from the type system’s perspective (even if their underlying, wrapped types are different), performing this kind of type erasure significantly reduces SwiftUI’s ability to efficiently update our views.\
  So, even if there are cases in which we might need to use AnyView, it’s often best to avoid it as much as possible.\
 Here are some examples on how to avoid `AnyView`:
 ### 1. Handling multiple return types:
 Best way is using the result builder we keep talking about, **@ViewBuilder**, so just mark the function/property with it. It also makes the code easier on the eyes.
 */
import SwiftUI

struct BadPracticeExample: View {
	@Binding var name: String
	var isEditable: Bool
	public var body: some View {
		content
	}

	private var content: AnyView {
		if isEditable {
			return AnyView(TextField("Name", text: $name))
		} else {
			return AnyView(Text(name))
		}
	}
}

struct GoodPracticeExample: View {
	@Binding var name: String
	var isEditable: Bool
	public var body: some View {
		content
	}

	@ViewBuilder
	private var content: some View {
		if isEditable {
			TextField("Name", text: $name)
		} else {
			Text(name)
		}
	}
}
/*:
 ### 2. Generic view properties
 Sometimes, we just want to store any type of View in a property, without caring for its type. One way of using this is declaring the property's type `AnyView`. But, as previously said, this can impact the way your views are updated.
 */
struct BadGenericView: View {
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	let content: AnyView
	var layout: AnyLayout {
		if horizontalSizeClass == .compact {
			return AnyLayout(VStackLayout())
		} else {
			return AnyLayout(HStackLayout())
		}
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("Please select your avatar:")
			layout {
				content
			}
		}
	}
}
/*: So to fix it, we can take a look at how HStack is defined:
 ```
 struct HStack<Content: View>: View {
	...
 }
 ```

 So we make the property adopt the exact same pattern — which will let us directly inject any View-conforming type as our `content`:
 */
struct GoodGenericView<Content: View>: View {
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	let content: Content
	var layout: AnyLayout {
		if horizontalSizeClass == .compact {
			return AnyLayout(VStackLayout())
		} else {
			return AnyLayout(HStackLayout())
		}
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("Please select your avatar:")
			layout {
				content
			}
		}
	}
}
//: [Next](@next)
