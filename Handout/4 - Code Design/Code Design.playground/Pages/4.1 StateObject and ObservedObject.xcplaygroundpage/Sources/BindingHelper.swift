import SwiftUI

//: This lets us seamlessly convert from a Floating point binding required by Slider to an Int binding that matches out model
public extension Binding<Float> {
    init(intBinding: Binding<Int>) {
        self = Binding {
            Float(intBinding.wrappedValue)
        } set: { update in
            intBinding.wrappedValue = Int(update)
        }
    }
}
