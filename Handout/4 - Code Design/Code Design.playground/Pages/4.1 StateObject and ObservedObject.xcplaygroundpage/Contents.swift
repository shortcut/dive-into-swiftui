//: [Previous](@previous)

import SwiftUI
import Combine
import PlaygroundSupport

/*:
 # StateObject and ObservedObject
 */

/*:
 The `@StateObject` and `@ObservedObject` modifiers are similar, but have different lifecycle behaviors that are important to understand to use them properly.

 `@ObservedObject` is an annotation that tells a SwiftUI view that if the `ObservableObject` assigned to that value emits changes, then the view should be updated.

 `@StateObject` tells the view to respond to updates just like `@ObservedObject`, but it also ensures that the @StateObject will only be created once per each **identified view**.

 That means that you if you use them incorrectly, you can either end up constantly re-creating an object and therefore not tracking state correctly with `@ObservedObject`, or you can end up with a `@StateObject` that doesn't updated alongside the view tree.
 */

class Counter: ObservableObject {
    @Published private(set) var count: Int
    var isCounting: Bool { cancellable != nil }
    @Published private var cancellable: AnyCancellable?

    init(initialCount: Int) {
        count = initialCount
    }

    func toggle() {
        if isCounting {
            stop()
        } else {
            start()
        }
    }

    func start() {
        cancellable = Timer.publish(every: 0.5, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.count += 1
            }
    }

    func stop() {
        cancellable = nil
    }
}

/*:
 One of the first pitfalls is that it's problematic to create an ObservedObject on init.
 */

struct InitCounterView: View {
    let title: String
    @ObservedObject private var counter: Counter = Counter(initialCount: 0)

    var body: some View {
        VStack {
            Text(title)
            Text("\(counter.count)")
            Button(counter.isCounting ? "Stop" : "Start",
                   action: counter.toggle)
        }
    }
}

PlaygroundPage.current.setLiveView(InitCounterView(title: "Test").padding())

/*:
 At first glance, it looks like this works, but when we place it inside something that re-creates the view, the problem with init-ing the @ObservedObject in the view shows up, if we change the text in the outer view, it re-creates the ObservedObject and you lose all of the associated state.
 */

struct InitCounterWrapper: View {
    @State private var title: String = "Test"

    var body: some View {
        VStack {
            TextField("Label", text: $title)
            InitCounterView(title: title)
        }
    }
}

PlaygroundPage.current.setLiveView(InitCounterWrapper().padding().frame(width: 100))

/*:
 To avoid this when using @ObservedObject, it should always be passed in from outside the view itself.
 */

struct InjectCounterView: View {
    let title: String
    @ObservedObject private(set) var counter: Counter

    var body: some View {
        VStack {
            Text(title)
            Text("\(counter.count)")
            Button(counter.isCounting ? "Stop" : "Start",
                   action: counter.toggle)
        }
    }
}

struct InjectCounterWrapper: View {
    @State private var title: String = "Test"
    @StateObject private var counter = Counter(initialCount: 0)

    var body: some View {
        VStack {
            TextField("Label", text: $title)
            InjectCounterView(title: title, counter: counter)
        }
    }
}
PlaygroundPage.current.setLiveView(InjectCounterWrapper().padding())

/*: This ensures that the ObservedObject is stable, even if the view is re-created, which happens often in SwiftUI. */

/*: `@StateObject` can have the opposite problem, if you pass too much information into it at init, it won't be updated properly even if the value is changed */

struct StateCounter: View {
    @StateObject private var counter: Counter

    init(count: Int) {
        self._counter = StateObject(wrappedValue: Counter(initialCount: count))
    }

    var body: some View {
        VStack {
            Text("\(counter.count)")
            Button(counter.isCounting ? "Stop" : "Start",
                   action: counter.toggle)
        }
    }
}

struct StateCounterWrapper: View {
    @State private var targetValue: Int = 0
    @State private var counterValue: Int = 0

    var body: some View {
        VStack {
            Slider(value: Binding(intBinding: $targetValue), in: 0...100)
            Text("\(targetValue)")
            Button("Update") {
                counterValue = targetValue
            }
            StateCounter(count: counterValue)
            Spacer()
        }
        .frame(width: 300, height: 300)
    }
}

PlaygroundPage.current.setLiveView(StateCounterWrapper().padding())

class UpdatingCounter: ObservableObject {
    @Published private(set) var count: Int = 0
    var isCounting: Bool { cancellable != nil }
    @Published private var cancellable: AnyCancellable?

    init() {
        // just keeping this around to count how many times we init
    }

    func update(count: Int) {
        self.count = count
    }

    func toggle() {
        if isCounting {
            stop()
        } else {
            start()
        }
    }

    func start() {
        cancellable = Timer.publish(every: 0.5, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.count += 1
            }
    }

    func stop() {
        cancellable = nil
    }
}

struct StateUpdatingCounter: View {
    @StateObject private var counter = UpdatingCounter()
    let count: Int

    init(count: Int) {
        self.count = count
        counter.update(count: count)
    }

    var body: some View {
        VStack {
            Text("\(counter.count)")
            Button(counter.isCounting ? "Stop" : "Start",
                   action: counter.toggle)
        }
        //: We can't depend on the init to be called every change, so instead we need to update on appear and on change:
        .onAppear {
            counter.update(count: count)
        }
        .onChange(of: count) { update in
            counter.update(count: update)
        }
    }
}

struct StateUpdatingCounterWrapper: View {
    @State private var targetValue: Int = 0
    @State private var counterValue: Int = 5

    var body: some View {
        VStack {
            Slider(value: Binding(intBinding: $targetValue), in: 0...100)
            Text("\(targetValue)")
            Button("Update") {
                counterValue = targetValue
            }
            Text("Non-updating")
            StateCounter(count: counterValue)
            Text("Updating")
            StateUpdatingCounter(count: counterValue)
            Spacer()
        }
        .frame(width: 300, height: 300)
    }
}

PlaygroundPage.current.setLiveView(StateUpdatingCounterWrapper().padding())

//: [Next](@next)
