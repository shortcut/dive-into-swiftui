//: [Previous](@previous)
/*: # Application
 ## Returning multiple subtypes of `View` in the same block of code

 ***Some*** keyword defines an opaque type, meaning that we can ignore the return value's concrete type and talk in terms of the protocol it is implemented (more details about how opaque types work [here](https://docs-swift-org.translate.goog/swift-book/LanguageGuide/OpaqueTypes.html?_x_tr_sl=en&_x_tr_tl=ro&_x_tr_hl=ro&_x_tr_pto=sc) ). It is very useful in SwiftUI because it allows for things like modifiers to applied for views no matter the type (like `.padding()` ) and don't stress much about the returned type.\
 **But**, the compiler is only able to infer the underlying return type when all of the code branches within a given function or computed property return the exact same type so, unfortunately, you are not allowed to have different types retuned in the same block of code.

 ![Matching Underlying Types Error](error1.jpg)

 `@ViewBuilder` fixes this problem by returning a wrapper type represents all the return types that the `View` contains.
 */
import SwiftUI

protocol CustomView {
	associatedtype Body : View

	var body: Self.Body { get }
}

struct ContentView: CustomView {
	@State var showButton = true

	// Removing the result '@ViewBuilder' will throw the "Function declares an opaque return type 'some View', but the return statements in its body do not have matching underlying types"
	@ViewBuilder
	var body: some View {
		if showButton {
			Button {
				showButton = false
			} label: {
				presentationText
			}
			.padding()
		} else {
			presentationText
				.padding()
		}
	}

	// Having the same return type works well without '@ViewBuilder'
	var presentationText: some View {
		if showButton {
			return Text("Press to take what is yours")
		} else {
			return Text("🍕 is yours!!")
		}
	}
}
//: [Next](@next)
