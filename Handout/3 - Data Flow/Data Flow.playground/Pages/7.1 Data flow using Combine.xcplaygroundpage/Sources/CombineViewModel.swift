import Foundation
import Combine

public class CombineViewModel: ObservableObject {
    public var tick: some Publisher<Void, Never> {
        subject
    }

    private var subject = PassthroughSubject<Void, Never>()
    @Published private var cancellable: (any Cancellable)?
    public var isCounting: Bool { cancellable != nil }

    public init() {}

    public func start() {
        cancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.subject.send(())
            }
    }

    public func stop() {
        cancellable = nil
    }
}
