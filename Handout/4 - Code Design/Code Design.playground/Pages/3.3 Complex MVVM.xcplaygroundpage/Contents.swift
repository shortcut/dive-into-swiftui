//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 # Complex MVVM
 */

/*:
 Eventually, our view model will need to store some sort of internal state, a common variant of this is needing to handle loading, loaded, and error states within a view. To do this we need to move from a value type to a reference type so that when the model is updated, there's still a reference pointing back to it.

 SwiftUI supports this pattern out of the box using ObservableObject and either an StateObject or a ObservedObject. For now we're going to use a StateObject, but we'll cover the difference between those and when to use each one in a later section.
 */

protocol UserService: AnyObject {
    func loadUser(id: String) async throws -> BackendModel
    func startProfileUpdate()
}

class ConcreteUserService: UserService {
    func loadUser(id: String) async throws -> BackendModel {
        BackendModel(firstName: "Cher",
                     lastName: nil,
                     accountValidUntil: .distantFuture,
                     profileImage: nil)
    }
    func startProfileUpdate() {
    }
}

struct UserLoadingView: View {
    class ViewModel: ObservableObject {
        enum State {
            case loading
            case loaded(UserView.ViewModel)
            case failed(Error)
        }

        @Published private(set) var state: State
        let loadUser: (_ userId: String, _ beginUpdateUserProfile: @escaping () -> Void) async throws -> UserView.ViewModel
        let userService: UserService
        //: We store the Task here so that we can cancel previous tasks when we start a new task
        private var task: Task<Void, Never>? {
            didSet {
                oldValue?.cancel()
            }
        }

        init(state: State = .loading,
             userService: UserService,
             loadUser: @escaping (_ userId: String, _ beginUpdateUserProfile: @escaping () -> Void) async throws -> UserView.ViewModel) {
            self.state = state
            self.loadUser = loadUser
            self.userService = userService
        }

        func load(userId: String) {
            task = Task {
                do {
                    state = .loaded(try await loadUser(userId, userService.startProfileUpdate))
                } catch {
                    state = .failed(error)
                }
            }
        }
    }

    let userId: String
    @StateObject private var viewModel: ViewModel

    init(userId: String,
         userService: UserService,
         loadUser: @escaping (_ userId: String, _ beginUpdateUserProfile: @escaping () -> Void) async throws -> UserView.ViewModel) {
        self.userId = userId
        _viewModel = StateObject(wrappedValue: ViewModel(userService: userService, loadUser: loadUser))
    }

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let userViewModel):
                UserView(viewModel: userViewModel)
            case .failed(let error):
                Text(error.localizedDescription)
            }
        }
        .onAppear() {
            viewModel.load(userId: userId)
        }
        .onChange(of: userId) { userId in
            viewModel.load(userId: userId)
        }
    }
}

enum Failure: Error, LocalizedError {
    case demo

    var errorDescription: String? {
        "Demonstrating the error state"
    }
}

let userService = ConcreteUserService()

// Now we can construct views that put the view model into any state without knowing anything about the APIs that perform the tasks
let waiting = UserLoadingView(userId: "test", userService: userService) { _, update in
    while true  {
        try? await Task.sleep(for: .seconds(60))
    }
    return UserView.ViewModel(name: "Never", isActive: false, profileImage: nil, beginUpdateProfileImage: update)
}

PlaygroundPage.current.setLiveView(waiting.padding().frame(width: 300, height: 300))

let loaded = UserLoadingView(userId: "Test Testerson", userService: userService) { name, update in
    return UserView.ViewModel(name: name,
                              isActive: true,
                              profileImage: nil,
                              beginUpdateProfileImage: update)
}

PlaygroundPage.current.setLiveView(loaded.padding().frame(width: 300, height: 300))

let failed = UserLoadingView(userId: "Test", userService: userService) { _, _ in
    throw Failure.demo
}

PlaygroundPage.current.setLiveView(failed.padding().frame(width: 300, height: 300))

//: Finally, we can create a "real" version that adapts data from the API. Because we're using a protocol, we can still mock the behavior 

let adapted = UserLoadingView(userId: "Test Testerson", userService: userService) { id, update in
    let user = try await userService.loadUser(id: id)
    return UserView.ViewModel(model: user, beginProfileImageUpdate: update)
}

PlaygroundPage.current.setLiveView(adapted.padding().frame(width: 300, height: 300))

/*:
 One of the complexities here is figuring out the right pattern on how to make sure you pass your dependencies throughout your app as things grow more complex.

 In general, views that have several linked dependencies should have those dependencies packaged in a protocol and passed to them via an object. If a view has dependencies that don't have relationships, then they can be passed in as values or closures.
 */

//: [Next](@next)
