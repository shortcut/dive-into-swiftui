//: [Previous](@previous)
/*: # Application
 ## Optional views
The last application we will mention is having optional views.\
What are those in the SwiftUI context? Simply not having any child views in one or more cases/situations.

 How does that look like by default? The compiler is complaining about not having any returned view from which it can infer the type.\
 ![Missing return error](error.jpg)

By adding the ***@ViewBuilder*** attribute, the compiler will receive automatically an **`EmptyView`** when the parent view is rebuilt in the unfavourable case. So no more writing `EmptyView()` or `AnyView()`!
 */
import SwiftUI

struct Profile: View {
	@State var selectedAvatar: (String, Color)?

	public var body: some View {
		content
			.background(Color.mint)
	}

	@ViewBuilder
	var content: some View {
		if let avatar =  selectedAvatar {
			VStack(alignment: .center, spacing: 20) {
				Text("This is your selected avatar")
					.font(.headline)
				Image(systemName: avatar.0)
					.foregroundColor(avatar.1)
					.font(.system(size: 60))
					.padding()
			}
		}
	}
}
//: [Next](@next)
