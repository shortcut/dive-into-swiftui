//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
## Overriding animations with Transactions
 
 Transaction is the context of the current state-processing update. SwiftUI creates a transaction for every state change. Transaction contains the animation that SwiftUI will apply during the state change and the property indicating whenever this transaction disables all the animations defined by the child views.
 
 SwiftUI provides a withTransaction() function that allows us to override animations at runtime, for example to remove an implicit animation and replace it with something custom.

 To do that, first create a new Transaction instance using whatever animation you want, then set its disablesAnimations value to true so you override any existing animations that would apply. Call withTransaction() using your transaction object, then go ahead and adjust all the state you want to change – it will all be animated using your transaction.
 */

struct WithTransactionExample: View {
    @State private var isZoomed = false

    var body: some View {
        VStack {
            Button("Toggle Zoom") {
                var transaction = Transaction(animation: .interactiveSpring(dampingFraction: 0.3))
                transaction.disablesAnimations = true

                withTransaction(transaction) {
                    isZoomed.toggle()
                }
            }

            Spacer()
                .frame(height: 100)

            Text("Zoom Text")
                .font(.title)
                .scaleEffect(isZoomed ? 2 : 1)
                .animation(.easeInOut(duration: 2), value: isZoomed)

        }
        .frame(width: 300, height: 300)
    }
}

PlaygroundPage.current.setLiveView(WithTransactionExample())

/*:
 For even more control you can attach a transaction() modifier to any view you want, allowing you to change or replace any animation used in a view.
 
 Note: Use this modifier on leaf views such as Image or Button rather than container views such as VStack or HStack. The transformation applies to all child views within this view; calling transaction(_:) on a container view can lead to unbounded scope of execution depending on the depth of the view hierarchy.
 */

struct TransactionExample: View {
    @State var flag = false

    var body: some View {
        VStack(spacing: 50) {
            HStack(spacing: 30) {
                Text("Rotation")
                    .rotationEffect(Angle(degrees:
                                            self.flag ? 360 : 0))

                Text("Rotation\nModified")
                    .rotationEffect(Angle(degrees:
                                            self.flag ? 360 : 0))
                    
                    .transaction { view in
                        view.animation =
                            view.animation?.delay(2.0).speed(2)
                    }

                Text("Animation\nReplaced")
                    .rotationEffect(Angle(degrees:
                                            self.flag ? 360 : 0))
                    .transaction { view in
                        view.animation = .interactiveSpring(
                            response: 0.60,
                            dampingFraction: 0.20,
                            blendDuration: 0.25)
                    }
            }

            Button("Animate") {
                withAnimation(.easeIn(duration: 2.0)) {
                    self.flag.toggle()
                }
            }
        }
    }
}

PlaygroundPage.current.setLiveView(TransactionExample())

//: [Next](@next)
