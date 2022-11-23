//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

//: ## EnvironmentObject and dependencies

/*:
 To be able to add something as an environmentObject, it needs to be an `ObservableObject`
 */
class SharedService: ObservableObject {
    @Published var userName: String = ""
    @Published var isLoggedIn: Bool = false

    var isUserValid: Bool {
        userName
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty == false
    }
}

/*:
 Any view can access an `@EnvironmentObject` with the property wrapper, the look up is performed by the object's class, so you don't need a key
 */
struct UserNameEntry: View {
    @EnvironmentObject var service: SharedService

    var body: some View {
        TextField("User name", text: $service.userName)
    }
}

/*:
 The object name also can be different in different child nodes
 */
struct LoginButton: View {
    @EnvironmentObject var renamedService: SharedService

    var body: some View {
        Button("Log in") {
            renamedService.isLoggedIn = true
        }
        .disabled(!renamedService.isUserValid)
    }
}

/*:
 And part of the magic is that if a middle layer doesn't use the environment object, we don't need to reference it at all.
 */
struct LoginView: View {
    var body: some View {
        VStack {
            UserNameEntry()
            LoginButton()
        }
    }
}

struct UserView: View {
    @EnvironmentObject var service: SharedService

    var body: some View {
        VStack {
            Text(service.userName)
            Button("Log out") {
                service.isLoggedIn = false
            }
        }
    }
}

/*:
 We need to store the environment at the point that it's injected, and it can be added to the environment with the `.environmentObject` modifier.
 */
struct RootView: View {
    @StateObject var service = SharedService()

    var body: some View {
        currentContent
            .environmentObject(service)
            .animation(.default, value: service.isLoggedIn)

    }

    @ViewBuilder private var currentContent: some View {
        LoginView()
            .padding()
            .sheet(isPresented: $service.isLoggedIn) {
                UserView()
                    .padding()
            }
    }
}

/*:
There's one important detail to keep in mind, if you fail to inject an EnvironmentObject into a view that uses it, your app will crash. In previous OS versions, presentations like `.sheet` wouldn't pass environment objects into children. It also complicates the use of previews, and can add complexity when passing from UIKit to SwiftUI.
 */


PlaygroundPage.current.setLiveView(
    RootView()
        .frame(width: 300, height: 300)
)

//: [Next](@next)
