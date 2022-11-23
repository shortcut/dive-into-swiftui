/*:
 # View Identity
 
 Identity, along with lifetime and dependencies, plays an important role in SwiftUI. Together, these three concepts inform how SwiftUI decides what needs to change, how, and when, resulting in the dynamic user interface you see onscreen.
 
 Let's focus on identity now!
 
 Each View has its own **identity**. That's how SwiftUI recognizes elements as the same or distinct across multiple updates of your app.
 
 
 Let's look at an example. You can tap on the square to move it to the bottom of the screen and back.
 */

import SwiftUI
import PlaygroundSupport

struct ViewIdentityExample1: View {
    @State private var isOnTopOfTheScreen: Bool = true

    var body: some View {
        VStack {
            if isOnTopOfTheScreen {
                customRectangle
            } else {
                customRectangle
                    .padding(.top, 400)
            }
        }
        .onTapGesture {
            withAnimation {
                isOnTopOfTheScreen.toggle()
            }
        }
        .frame(width: 300, height: 500, alignment: .top)
        .background(.white)
    }
    
    var customRectangle: some View {
        Rectangle()
            .fill(.red)
            .cornerRadius(10)
            .padding()
            .frame(width: 100, height: 100, alignment: .center)
    }
}

PlaygroundPage.current.setLiveView(ViewIdentityExample1())

/*:
 Looking at these 2 squares, do they look like two different views, completely distinct from each other? Or could they be the same view, just in a different place?
 
 Run the second example.
 */

struct ViewIdentityExample2: View {
    @State private var isOnTopOfTheScreen: Bool = true

    var body: some View {
        VStack {
            Rectangle()
                .fill(isOnTopOfTheScreen ? .red : .yellow)
                .cornerRadius(10)
                .padding()
                .frame(width: 100, height: 100, alignment: .center)
                .padding(.top, isOnTopOfTheScreen ? 0 : 400)
        }
        .onTapGesture {
            withAnimation {
                isOnTopOfTheScreen.toggle()
            }
        }
        .frame(width: 300, height: 500, alignment: .top)
        .background(.white)
    }
}

PlaygroundPage.current.setLiveView(ViewIdentityExample2())

/*:
 If the squares are different(have different identities), that means that their transitions are independent, such as fading in and out. But if it is the same view, it will involve a single transition that slides across the screen, moving from one point to another.
 
 Views that share the same identity represent different states of the same UI element. So connecting views across different states is important, because that's how SwiftUI understands how to transition between them. This is the key concept behind view identity.
 
 Both of these strategies can work, but SwiftUI generally recommends the second approach. By default, try to preserve identity and provide more fluid transitions.
*/

//: [Next](@next)
