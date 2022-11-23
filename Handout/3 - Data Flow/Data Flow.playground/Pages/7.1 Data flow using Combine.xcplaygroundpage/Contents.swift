//: [Previous](@previous)

import SwiftUI
import Combine
import PlaygroundSupport

//: ## Data flow using Combine

/*:
This exposes a view model with a publisher, and then a start + stop function.
 */
 protocol CombineViewModelProtocol: ObservableObject {
    var tick: any Publisher<Void, Never> { get } // Publishes each tick of an internal counter
    var isCounting: Bool { get } // indicates the view model is counting

    func start() // Start counting
    func stop() // Stop counting
 }

/*:
 We can use `onReceive` to react each time the publisher sends an event.
 */
struct PublisherView: View {
    @StateObject var viewModel = CombineViewModel()
    @State private var numberOfTicks = 0

    var body: some View {
        VStack {
            Text("Number of ticks: \(numberOfTicks, format: IntegerFormatStyle())")
                .fixedSize()
                .font(.body.monospacedDigit())
            if viewModel.isCounting {
                Button("Stop", action: viewModel.stop)
            } else {
                Button("Start", action: viewModel.start)
            }
        }
        .onReceive(viewModel.tick) { _ in
            numberOfTicks += 1
        }
    }
}

PlaygroundPage.current.setLiveView(PublisherView().padding())

//: [Next](@next)
