//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 # Simple MVVM
 */

/*:
Simple MVVM can be used when there isn't any internal state to your view model, but there are enough values, transformations, or other information that you want to isolate that from the View itself.
 */

struct UserView: View {
    struct ViewModel {
        let name: String
        let isActive: Bool
        let profileImage: URL?
        let beginUpdateProfileImage: () -> Void
    }

    let viewModel: ViewModel

    var body: some View {
        VStack {
            Button(action: viewModel.beginUpdateProfileImage) {
                AsyncImage(url: viewModel.profileImage) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "person.fill")
                        .resizable()
                }
                .frame(width: 200, height: 200)
            }
            .clipShape(Circle())
            LabeledContent("Name", value: viewModel.name)
            LabeledContent("Is Active", value: viewModel.isActive ? "Yes" : "No")
        }
    }
}

/*:
 Another win from MVVM is that even before we know what the data from the back end looks like, we've defined what we need for the view, and can start prototyping the view and testing it out.
 */

let model = UserView.ViewModel(name: "Test Testerson",
                               isActive: true,
                               profileImage: URL(string: "https://placekitten.com/200/200"),
                               beginUpdateProfileImage: {})
let demoView = UserView(viewModel: model)
PlaygroundPage.current.setLiveView(demoView.padding())

struct BackendModel {
    let firstName: String?
    let lastName: String?
    let accountValidUntil: Date
    let profileImage: URL?
}

/*:
 Now that we know what the model from the back end looks like, we can write a custom init that handles properly converting from the back end content, to what we want to display in the view.
 */
extension UserView.ViewModel {
    init(model: BackendModel, beginProfileImageUpdate: @escaping () -> Void) {
        var nameComponents = PersonNameComponents()
        nameComponents.givenName = model.firstName
        nameComponents.familyName = model.lastName
        self.name = nameComponents.formatted()
        self.isActive = model.accountValidUntil < Date()
        self.profileImage = model.profileImage
        self.beginUpdateProfileImage = beginProfileImageUpdate
    }
}

let backendModel = BackendModel(firstName: nil,
                                lastName: "Namington",
                                accountValidUntil: .distantFuture,
                                profileImage: URL(string: "https://placekitten.com/250/250"))
let updatedView = UserView(viewModel: .init(model: backendModel, beginProfileImageUpdate: {}))
PlaygroundPage.current.setLiveView(updatedView.padding())

//: [Next](@next)
