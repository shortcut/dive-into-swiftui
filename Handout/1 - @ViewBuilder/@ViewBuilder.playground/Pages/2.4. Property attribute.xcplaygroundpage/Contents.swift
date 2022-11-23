//: [Previous](@previous)
/*: # Application
## Passing body-like structure of child views with initializers/methods

We can clean up the code even more by adding @ViewBuilder direct to property for both View and closure. Also, adding it to any other property of type `some View`, allows you have even more blocks of code behaving like `body`.
 ```
 struct MyView<Content: View>: View {

	 @ViewBuilder var content: Content // 1

	 // or

	 @ViewBuilder var content: (Int) -> Content // 2
 }
 ```

 One other neat trick is that you can pass the closure property directly to the `VStack` or `HStack`.
 ```
 struct VHStack<Content: View>: View {
	 @Environment(\.horizontalSizeClass) var horizontalSizeClass
	 @ViewBuilder var content: () -> Content

	 var body: some View {
			if horizontalSizeClass == .compact {
				VStack(content: content)
			 } else {
				HStack(content: content)
			 }
	 }
 }
 ```
 Applying what we know now in the last example will look like this:
*/
import SwiftUI

struct ProfileImagePicker<Content: View>: View {
	@Environment(\.horizontalSizeClass) var horizontalSizeClass

	@ViewBuilder let content: () -> Content

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("Please select your avatar:")
			if horizontalSizeClass == .compact {
				VStack(content: content)
			} else {
				HStack(content: content)
			}
		}
	}
}

struct Profile: View {
	let avatars = ["brain.head.profile", "person.crop.circle", "person.crop.circle.fill"]
	let colors: [Color] = [.red, .cyan, .brown]

	@State var selectedAvatar: (String, Color)?

	public var body: some View {
		if selectedAvatar != nil {
			VStack(alignment: .center, spacing: 20) {
				selectedAvatarView
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

	@ViewBuilder
	var selectedAvatarView: some View {
		if let avatar = selectedAvatar {
			Text("This is your selected avatar")
				.font(.headline)
			Image(systemName: avatar.0)
				.foregroundColor(avatar.1)
				.font(.system(size: 60))
				.padding()
		}
	}
}
//: [Next](@next)
