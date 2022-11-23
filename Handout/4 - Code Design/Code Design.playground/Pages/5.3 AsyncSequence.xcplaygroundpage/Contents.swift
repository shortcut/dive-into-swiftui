//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 # Modern Swift Concurrency
 */

let session = URLSession.shared
let urlRequest = URL(string: "https://www.google.com").map { URLRequest.init(url: $0) }!

/*:
 AsyncSequence is a way of handling a series of events over time. It works just like standard async / await, but you `await` each value emitted from the sequence. Many operators of the operators that work on collections in Swift also can be applied to AsyncSequence, and there are even more available in the [Swift Async Algorithms](https://github.com/apple/swift-async-algorithms) package
 */

Task {
    do {
        let (bytes, response) = try await session.bytes(for: urlRequest)
        (response as? HTTPURLResponse)?.statusCode
        let alteredBytes = bytes.characters
            .filter { c in
                CharacterSet.whitespacesAndNewlines.isDisjoint(with: CharacterSet(c.unicodeScalars))
            }
            .prefix(15)
            .map {
                "\($0)"
            }
        var string = ""
        for try await step in alteredBytes {
            string += step
            try await Task.sleep(for: .milliseconds(10))
        }
        string
    } catch {
        error
    }
}

/*:
 This is defining a whole series of operators on the async sequence, and none of the steps are performed until we start awaiting the results.

We can also layer async work in this, and async / await handles this gracefully as move data becomes available from the AsyncSequence.
*/
//: [Next](@next)
