//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 # Async, await
 */

let session = URLSession.shared
let urlRequest = URL(string: "https://www.google.com").map { URLRequest.init(url: $0) }!

/*:
 Before async await, you'd use a closure based API to perform asynchronous work in a non-blocking manner, fetching data from the web is a great example:
 */
let task = session.dataTask(with: urlRequest) { data, response, error in
    if let error {
        error
    } else if let data, let response {
        data.count
        (response as? HTTPURLResponse)?.statusCode
    } else {
        "What do we do here?"
    }
}
task.resume()


/*:
 There's a couple problems here, first is that it's easy to forget to run `resume()` on your task and sit wondering why nothing is happening. After that, the API returns `(Data?, URLResponse?, Error?)`, so you don't know what are allowed combinations of null and non-null values.

 Apple has provided async versions of many common functions from the standard library, for instance the async/await version of fetching a url request:
 */

Task {
    do {
        let (data, response) = try await session.data(for: urlRequest)
        data.count
        (response as? HTTPURLResponse)?.statusCode
    } catch {
        error
    }
}

/*:
 This unifies creating the task, and makes it obvious when the task will be called. It also makes it clear which states are possible so that we can depend that there will always either be `(Data, URLResponse)` or throw an error.
 */

//: [Next](@next)
