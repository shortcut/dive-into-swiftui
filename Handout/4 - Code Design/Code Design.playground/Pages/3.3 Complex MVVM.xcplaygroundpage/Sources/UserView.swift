import SwiftUI

public struct UserView: View {
    public struct ViewModel {
        public let name: String
        public let isActive: Bool
        public let profileImage: URL?
        public let beginUpdateProfileImage: () -> Void

        public init(name: String, isActive: Bool, profileImage: URL?, beginUpdateProfileImage: @escaping () -> Void) {
            self.name = name
            self.isActive = isActive
            self.profileImage = profileImage
            self.beginUpdateProfileImage = beginUpdateProfileImage
        }
    }

    let viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
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

public struct BackendModel {
    public let firstName: String?
    public let lastName: String?
    public let accountValidUntil: Date
    public let profileImage: URL?

    public init(firstName: String?,
         lastName: String?,
         accountValidUntil: Date,
         profileImage: URL?) {
        self.firstName = firstName
        self.lastName = lastName
        self.accountValidUntil = accountValidUntil
        self.profileImage = profileImage
    }
}

public extension UserView.ViewModel {
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
