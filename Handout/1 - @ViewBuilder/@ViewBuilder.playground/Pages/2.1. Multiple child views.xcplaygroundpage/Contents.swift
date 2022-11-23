//: [Previous](@previous)
/*: # Application

 ## Creating multiple child views
 As previously said, *@ViewBuilder* is used to create multiple child views for a specific view. It might come as shock, but you are using it already:

 ```
 public protocol View {
	 associatedtype Body : View

	 @ViewBuilder var body: Self.Body { get }
 }
 ```

 And because the body property is defined using *@ViewBuilder* attribute, you can implement the view protocol as follows:
 ```
 struct ContentView: View {
	 var body: some View {
			 Text("Hello, world!")
				.padding()
			 Text("You are attending a SwiftUI workshop!")
				.padding()
	 }
 }
 ```

 But you knew this already because this is how you implement a basic view. How does the code look without the attribute?

 ```
 protocol CustomView {
	 associatedtype Body : View

	 var body: Self.Body { get }
 }
 ```

 Implementing it should look like:
 ```
 struct ContentView: CustomView {
	 var body: some View {
			 Text("Hello, world!")
				.padding()
			 Text("You are attending a SwiftUI workshop!")
				.padding()
	 }
 }
 ```
 Building the code above, you would see an error because of the missing `return` keyword.

![Return missing error](error1.jpg)

 Adding the `returns` will result in only one the views being used and returning an array of subtypes of `View` goes against the protocol definition.

 ![Multiple returns warning](warning1.jpg)

 ![Array of Text](error2.jpg)

 But do not despair! We can still make this work by adding the attribute explicitly to the body property. More details about how ***@ViewBuilder*** works with properties [here](2.4%20-%20Property%20attribute).
 */
import SwiftUI

protocol CustomView {
	associatedtype Body : View

	var body: Self.Body { get }
}

struct ContentView: CustomView {
	@ViewBuilder
	var body: some View {
		Text("Hello, world!")
			.padding()
		Text("You are attending a SwiftUI workshop!")
			.padding()
	}
}

/*:
 ⚠️ be mindful when returning multiple `Views` that do not sit in a container, as in the example above, we're returning 2 `Text` Views in the `body`. This will have different behaviours depending on what container your `body` returns into.
 */

//: Fun fact: this is how VStack and HStack work with multiple subviews!\
//: [Next](@next)
