//: [Previous](@previous)
/*: # Application
 ## Passing body-like structure of child views with initializers/methods
 One other very useful feature of ***@ViewBuilder*** is adding it inside initializers or methods. It allows you to pass a body-like structure of child views, helping with code reuse and abstraction. You can use the resulting view of the closure right away or store it in a property.

 ```

 let content: Content // 1

 init(@ViewBuilder _ content: () -> Content) {
	self.content = content()
 }
 
 ```

 For reference, it is used in `VStack` and `HStack` to be able to pass a many views that get displayed with the same alignment.

 Did you ever wandered what's an easy way to display a list of images, that scrolls differently depending of the phone's orientation? Here is one way using ***@ViewBuilder*** in the initializer:
 
 */
import SwiftUI

struct ProfileImagePicker<Content: View>: View {
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	
	let content: Content
	var layout: AnyLayout {
		if horizontalSizeClass == .compact {
			return AnyLayout(VStackLayout())
		} else {
			return AnyLayout(HStackLayout())
		}
	}

	init(@ViewBuilder _ content: () -> Content) {
		self.content = content()
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

struct Profile: View {
	let avatars = ["brain.head.profile", "person.crop.circle", "person.crop.circle.fill"]
	let colors: [Color] = [.red, .cyan, .brown]

	@State var selectedAvatar: (String, Color)?

	public var body: some View {
		if let avatar =  selectedAvatar {
			VStack(alignment: .center, spacing: 20) {
				Text("This is your selected avatar")
					.font(.headline)
				Image(systemName: avatar.0)
					.foregroundColor(avatar.1)
					.font(.system(size: 60))
					.padding()
			}
		} else {
			ProfileImagePicker {
				ForEach(avatars, id: \.self) { avatar in
					ForEach(colors, id: \.self) { color in
						Image(systemName: avatar)
							.foregroundColor(color)
							.font(.system(size: 30))
							.padding()
							.onTapGesture {
								selectedAvatar = (avatar, color)
							}
					}
				}
			}
		}
	}
}
/*: Another example on how you could use ***@ViewBuilder*** with methods attributes is when you want a wrapper over you content, like a placeholder view while loading your data.
 */
extension View {
	func placeholder<Content: View>(
		when shouldShow: Bool,
		alignment: Alignment = .leading,
		@ViewBuilder placeholder: () -> Content) -> some View {

			ZStack(alignment: alignment) {
				placeholder().opacity(shouldShow ? 1 : 0)
				self
			}
		}
}

//: [Next](@next)
