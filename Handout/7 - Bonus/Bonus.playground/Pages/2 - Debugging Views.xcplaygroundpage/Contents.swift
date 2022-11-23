//: [Previous](@previous)

/*: # Debugging views
 
 Ever tried setting up a breakpoint in `body` in order to determine what happens during a weird animation transition? We can probably conclude, just as much as you have, that you cannot possibly get conclusive information from setting up a breakpoint in `body` because you simply do not have control over when it's called and why it's called, what values it reference etc.
 
 The confidence about the drawing cycle of `UIKit` can lead us into making poor decisions about the  `SwiftUI` drawing cycle. Sometimes the re-draw might be triggered but we don't know why; sometimes the redraw happens but nothing changes; sometimes the model changes and the View does not. Sadly, there is no obvious way of debugging this, depending on the setup that you are in. Most of the debugging should happen in the `ViewModel`, because that should be the source of truth. The `View` should only reflect what the `ViewModel` exposes. But for other situations there is a glimpse of hope and it comes into the form of a private API:
 
 - `Self._printChanges()`; if put in the `body` or in any computed property/ function that is called from within the `body` of a `View` it can detect and print to the console the changes that has caused the property/ function to be called in the first place. The is particularly useful for debugging weird situations in which, even if the data in the `View` is the same, its redrawn nonetheless ~ maybe the `id` of the data has changed, but the content is the same.
 
 Although, when adding `Self._printChanges()` the compiler will complain: "Type '()' cannot conform to 'View'". That is because we're adding a non-view returning statement to the `@ViewBuilder` context and the compiler doesn't know how to handle it. You can fix this by adding an explicit `return` to what previously it was synthesized.
 
 Let's explore a convenience way of debugging Views:
 */

import SwiftUI

/// `View` that will print to console any changes that will trigger its redraw cycle.
/// Conformance to `View` is required so that we can easily replace a certain view's conformance.
protocol DebuggedView: View {
		
	/// The actual body that will be debugged upon redraw.
	/// Reuse the `View.Body` associatedtype because we're not adding anything else to it.
	@ViewBuilder var debuggedBody: Body { get }
}

extension DebuggedView {
	
	/// Default implementation of the `View.body` protocol requirement.
	var body: some View {
		Self._printChanges()
		return debuggedBody
	}
}

/*:
 Now, with a simple replacement of `: View` -> `: DebuggedView` and `var body: some View` -> `var debuggedBody: some View` you can start debugging a `View` in a plug-and-play style.
 
 Other debugging techniques which no person should be ashamed of using are:
 
 - Make the View that you are trying to debug more obvious. Make heavy use of `.background(_:)` View modifier in order to determine frame sizes, order, positions etc;
 - Add a `Text` View containing all the data you want to debug as an overlay (`.overlay(_:alignment:)`) so that you can see, live, what and where changes are being performed.
 - `Previews` and `Live Previews`. With a powerful mocking setup you'll never need to run the app and you have total control over the data;
 */

//: [Next](@next)
