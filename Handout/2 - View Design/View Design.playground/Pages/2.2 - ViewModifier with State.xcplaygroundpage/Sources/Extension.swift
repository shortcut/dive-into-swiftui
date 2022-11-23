import SwiftUI

public extension View {
	
	public func runInTerminalSection() -> some View {
		VStack(alignment: .leading, spacing: 15.0) {
			HStack {
				Image(systemName: "terminal.fill")
				Text("try it yourself!")
					.frame(maxWidth: .infinity, alignment: .leading)
				Image(systemName: "play.fill")
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			self
				.font(.system(size: 15.0, weight: .light).italic())
		}
		.padding()
		.background(Color.gray)
		.clipShape(RoundedRectangle(cornerRadius: 12.0))
	}
}

