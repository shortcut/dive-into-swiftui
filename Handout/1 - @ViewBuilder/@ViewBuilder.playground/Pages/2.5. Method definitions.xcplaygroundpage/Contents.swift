//: [Previous](@previous)
/*: # Application
## Method definitions
Just like `body`, we can make a function that returns `some View` ignore the `return` keyword, and have multiple types of structs, that implement `View`, returned. This is extremely useful when you need to create different child views depending on parameters.
 */
import SwiftUI

enum ProfileState {
	case notStarted
	case incomplete
	case completed
}

struct ProfilePage: View {
	var profileState: ProfileState = .notStarted

	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Your profile")
				.font(.largeTitle)
			Divider()
				.frame(width: 1)
				.overlay(.red)
			pageContent(profileState)

		}
	}

	@ViewBuilder
	func pageContent(_ profileState: ProfileState) -> some View {
		Group {
			switch profileState {
				case .notStarted:
					Button {
						// Go to the profile creation page
					} label: {
						Text("Create your profile")
					}
				case .incomplete:
					Text("Your profile is incomplete!")
					Button {
						// Go to the profile creation page
					} label: {
						Text("Fill your information")
					}
				case .completed:
					Text("Congratulations on completing your profile!")
					// Display completed information
			}
		}
		.foregroundColor(.black)
		.font(.body)
	}
}
/*:
 - Callout(TIP): If you want to apply **the same** modifiers for views resulting from and if/else or switch statement, you can wrap it in a [Group](https://developer.apple.com/documentation/swiftui/group).
 */
//: [Next](@next)
