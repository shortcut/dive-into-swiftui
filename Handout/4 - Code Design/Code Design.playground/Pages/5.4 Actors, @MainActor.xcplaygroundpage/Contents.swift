//: [Previous](@previous)

import SwiftUI
import UIKit
import PlaygroundSupport

/*:
 # Actors, @MainActor
 */

/*
 Actors provide isolated collections of state, they can access their own values synchronously, but access from outside the actor is always async.
 */

actor Demo {
    var count: Int = 0

    var unsafeCount: Int {
        count
    }

    func doWork() {
        count += 1
    }
}

let demo = Demo()

/*: Due to actor isolation, this isn't allowed:
 ```swift
 print(demo.count)
 demo.doWork()
 ```
 */

Task {
    // All outside access to the actor is async
    await demo.doWork()
    await demo.count
}

/*:
 One important thing to note, is that while actors isolate access, if you use async functions actor isolation doesn't guarantee that the work in a given function will apply in order.
 */
actor ReentantDemo {
    var count: Int = 0

    func doWork() async {
        count += 1
        try? await Task.sleep(for: .milliseconds(500))
        count *= 2
    }

    func doWork2() async {
        count += 1
        count *= 2
    }
}

let demo2 = ReentantDemo()
let demo3 = ReentantDemo()

Task {
    async let a = demo2.doWork()
    async let b = demo2.doWork()
    async let c = demo3.doWork2()
    async let d = demo3.doWork2()

    await (a, b, c, d)
    await demo2.count
    await demo3.count
}

/*:
 The most important actor to know about is `MainActor`, it's the structured concurrency way of ensuring that work is done on the main thread.

The @MainActor annotation exists to mark types, functions, or tasks as needing to be executed on the main queue. One important thing to realize, is that this only is a guarantee from within the world of structured concurrency, calling an @MainActor annotated values and **methods from outside of structured concurrency won't enforce this**.
 */

//: All methods or variables on these types will be executed on the main actor:
@MainActor class SomeView: UIView {}

@MainActor struct SwiftUIView: View {
    var body: some View {
        Text("Test")
    }
}

/*
You can also strategically mark values or functions as requiring the main actor, including in protocols. An important example is that the `body` in `View` is marked as `@MainActor` in the protocol definition.
 */


protocol AsyncProtocol {
    @MainActor var isRead: Bool { get set }
    @MainActor func updateUI()
}

/*:
 Finally, you an explicitly dispatch a task to the main actor. The two ways of doing this are:
 */

Task { @MainActor in
    // Work on the main queue
}

Task {
    await MainActor.run {
        // work on the main queue
    }
}

/*:
 Like an `actor` the mainActor annotation requires using `await` if you're not on the `MainActor`, but once you're on the main actor, you can run anything that's isolated to the main actor synchronously.
 */

class Concrete: AsyncProtocol {
    var isRead = false

    func updateUI() {
        isRead.toggle()
    }

    func otherWork() {
        Task { @MainActor [weak self] in
            self?.isRead = false
        }
    }
}

let concrete = Concrete()

Task {
    await concrete.updateUI()
    await concrete.isRead
    await concrete.updateUI()
    await concrete.isRead
}

Task { @MainActor in
    concrete.updateUI()
    concrete.isRead
    concrete.updateUI()
    concrete.isRead
}

//: [Next](@next)
