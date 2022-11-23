//: [Previous](@previous)

/*:
 # Modern Swift Concurrency
 */

/*:

 Swift 5.5 added support for structured concurrency with async / await, AsyncSequence and actors.

Structured concurrency means that there is a system that manages threads with clear entry and exit points. In Swift's structured concurrency, the `await` keyword means that work may be performed on another thread and when you return from that await, your local state may have changed. The `async` keyword means that the function may need to perform work on another thread. `yield` is a way of letting the system temporarily take over the thread that you're using to make sure long running tasks don't hog resources. An AsyncSequence is a series of values emitted over time, so you can `await` the sequence emitting a new value.

 Finally an `actor` is a reference type that isolates access to an internal thread. That means that to read or write values from the actor it will always be async unless you annotate it otherwise, and inside the actor nothing else can change state from under you in a synchronous context. And there's the `@MainActor` annotation, which ensures code is run on the main actor.
 */

//: [Next](@next)
