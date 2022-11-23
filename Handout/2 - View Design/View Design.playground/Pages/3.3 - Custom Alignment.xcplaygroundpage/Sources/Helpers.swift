import SwiftUI

public struct AvatarImage: View {
	
	public init() { }
	
	public var body: some View {
		Image(uiImage: UIImage(named: "avatar.png")!)
			.resizable()
			.scaledToFit()
			.cornerRadius(5.0)
	}
}

public struct TextChatBubble: View {
	
	public let text: String?
	
	public init(text: String? = nil) {
		self.text = text
	}
	
	public var body: some View {
		Text(text ?? "I know, right! I used a lot of time to create this little gem. You are never going to guess the message.")
			.font(.headline)
			.padding(11.0)
			.background(Color.gray)
			.cornerRadius(4.0)
	}
}
