//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 ## Matched Geometry Effect
 
 MatchedGeometryEffect modifier helps us to create a smooth transition between 2 views. When inserting a view in the same transaction that another view with the same key is removed, the system will interpolate their frame rectangles in window space to make it appear that there is a single view moving from its old position to its new position.
 
 By default, SwiftUI uses a fade in/fade out effect to animate these views. But **matchedGeometryEffect** can animate position and size between them. What we need to do is link two views together.
 
 To achieve this, you need to use the @Namespace property wrapper to create a global namespace for your views. Next you need to add .matchedGeometryEffect() to all the views you want to animate with a synchronized effect. The id parameter must be the same between paired views.
 
 Note: The order where you place the modifier is important!
 */


struct MatchedGeometryEffectView: View {
    @Namespace private var animation
    @State private var isSwitched = false

    var frame: Double {
        isSwitched ? 300 : 44
    }

    var body: some View {
        VStack {
            if isSwitched {
                HStack(spacing: 20) {
                    Circle()
                        .fill(Color.blue)
                        .matchedGeometryEffect(id: "circle1", in: animation)
                        .frame(width: 50, height: 50)
                    
                    Circle()
                        .fill(Color.cyan)
                        .matchedGeometryEffect(id: "circle2", in: animation)
                        .frame(width: 50, height: 50)
                }
            } else {
                HStack(spacing: 20) {
                    Circle()
                        .fill(Color.cyan)
                        .matchedGeometryEffect(id: "circle2", in: animation)
                        .frame(width: 50, height: 50)
                    
                    Circle()
                        .fill(Color.blue)
                        .matchedGeometryEffect(id: "circle1", in: animation)
                        .frame(width: 50, height: 50)
                }
            }
        }
        .padding()
        .onTapGesture {
            withAnimation(.spring()) {
                isSwitched.toggle()
            }
        }
    }
}

PlaygroundPage.current.setLiveView(MatchedGeometryEffectView())
