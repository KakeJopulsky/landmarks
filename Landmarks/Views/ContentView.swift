import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured
    @State private var isLoggedIn: Bool = false
    @State var user: Profile

    enum Tab {
        case featured
        case list
    }
    
    func login() {
        IterableHelper.login(email: user.email, username: user.username)
        IterableHelper.segmentIdentify(userId: user.username, traits: ["email" : user.email])
        var dataFields = [String: Any]()
        dataFields["prefersNotifications"] = user.prefersNotifications
        IterableHelper.updateUserProfile(dataFields: dataFields)
        self.isLoggedIn = true
    }

    var body: some View {
        if isLoggedIn {
            TabView(selection: $selection) {
                CategoryHome(user: user)
                    .tabItem {
                        Label("Featured", systemImage: "star")
                    }
                    .tag(Tab.featured)

                LandmarkList()
                    .tabItem {
                        Label("List", systemImage: "list.bullet")
                    }
                    .tag(Tab.list)
            }
        } else {
            VStack {
                TextField("Username", text: $user.username)
                TextField("Email address", text: $user.email)
                Button("Sign In", action: login)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let userPreview = Profile(
        username: "Tiago",
        email: "Pereira"
    )
    static var previews: some View {
        ContentView(user: userPreview)
            .environmentObject(ModelData())
    }
}
