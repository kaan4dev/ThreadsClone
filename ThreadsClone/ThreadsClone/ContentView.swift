import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        TabView {
            FeedView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)

            Search()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)

            NewThreadView(user: viewModel.users.first ?? defaultUser(), viewModel: viewModel)
                .tabItem {
                    Image(systemName: "plus")
                    Text("New Thread")
                }
                .tag(2)

            LikedThreadsView(user: viewModel.users.first ?? defaultUser())
                .tabItem {
                    Image(systemName: "heart")
                    Text("Liked Threads")
                }
                .tag(3)

            User(user: viewModel.users.first ?? defaultUser())
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(4)
        }
        .accentColor(.black)
        .navigationBarBackButtonHidden(true)
    }
    
    private func defaultUser() -> UserModel {
        UserModel(
            id: UUID().uuidString,
            username: "defaultuser",
            fullName: "Default User",
            imageName: "defaultImage",
            isVerified: false,
            likedThreads: [],
            threadMessage: "This is a default user."
        )
    }
}
