//: [Previous](@previous)
/*: # View Hierarchy
 ## Under the hood
 So how does ***@ViewBuilder*** fit in this View Hierarchy?

 As we previously said, ***@ViewBuilder*** is one of the result builders available in SwiftUI. They were first introduced as a semi-official language feature called “function builders” as part of the Swift 5.1 release, but has since been promoted into a proper part of the language as of Swift 5.4.

 Result builders in Swift allow you to build up a result using ‘build blocks’ lined up. They can be seen as an embedded domain-specific language (DSL) for collecting parts that get combined into a final result.

We've seen how we can use it in the last chapter, but what about a glimpse on how it is defined?
 ```
 @resultBuilder struct ViewBuilder {
	 static func buildBlock(_ components: Component) -> Component {
	 }
 }
 ```
 So the black magic behind it, is that as **`result builder`**, ***@ViewBuilder*** has various `buildBlock` static functions that know how to handle multiple cases of combining views into a single result of type `View`. When no block is provided, an **`EmptyView`** is returned for us.

 - Important: The most views @ViewBuilder knows how to combine is 10 as described in the method definition below, so be sure to break your code into smaller blocks, defined as properties, methods or other structs, that you combine afterwards. 

 ```
 static func buildBlock() -> EmptyView

 static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9) -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)>
 ```

 In case you are curious, [here](https://developer.apple.com/documentation/swiftui/viewbuilder) are all the methods definitions described by Apple:

 ![@ViewBuilder buildBlock definitions](definitions.jpg)

 If you are curious how to create your own result builder, avanderlee.com has a great [tutorial](https://www.avanderlee.com/swift/result-builders/) on it.
 */
//: [Next](@next)
