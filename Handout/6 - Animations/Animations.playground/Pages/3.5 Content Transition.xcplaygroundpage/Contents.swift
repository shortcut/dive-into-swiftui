//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 ## Content Transition
 
 A new kind of transition, recently added in iOS16, that applies to the content within a single view, rather than to the insertion or removal of a view.
 
 In the previous versions of SwiftUI, we couldn’t apply transitions to the view’s content, such as Text View Content or system images.
 
 To set the behavior of content transitions within a view, we can add the contentTransition(_:) modifier, and passing in one of the defined ContentTransition.
 
 The provided ContentTransition can present an **opacity** animation for content changes, an **interpolated** animation of the content’s paths as they change, or perform no animation at all by using **identity**.
 
 Note: The contentTransition(_:) modifier only has an effect within the context of an Animation.
 */
struct ContentTransitionView: View {
    @State private var flag = false
    
    var body: some View {
        VStack {
            Text(verbatim: "1000")
                .font(Font.system(size: 20))
                .fontWeight(flag ? .black : .light)
                .foregroundColor(flag ? .yellow : .red)
        }
        .contentTransition(.opacity)
        .frame(width: 200, height: 200)
        .onTapGesture {
            withAnimation(.default.speed(0.2)) {
                flag.toggle()
            }
        }
    }
}

PlaygroundPage.current.setLiveView(ContentTransitionView())

/*:
 SwiftUI provides a type of ContentTransition that works with numeric text, understands how the number changed, and provides a nice visual effect that changes only the needed part of the Text view representing a number.
 */

struct TextContentView: View {
    @State private var number = "99"
    
    var body: some View {
        Text(verbatim: number)
            .font(.system(size: 36))
            .contentTransition(.numericText())
            .onTapGesture {
                withAnimation(.default.speed(0.2)) {
                    number = "98"
                }
            }
    }
}

PlaygroundPage.current.setLiveView(TextContentView())


//: [Next](@next)
