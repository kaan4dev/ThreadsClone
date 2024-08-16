import SwiftUI

struct ContentView: View
{
    @State private var selectedTab = 0

    let sampleUser = UserModel(
        username: "kaanncakir",
        fullName: "Kaan Cakir",
        imageName: "mainUser",
        isVerified: true,
        threadMessage: "meriçi çok seviyorum.",
        likedThreads: ["meriç", "nehir", "gün"]
    )

    var body: some View
    {
        TabView(selection: $selectedTab)
        {
            Home()
                .tabItem
            {
                Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
            }
            .onAppear
            {
                selectedTab = 0
            }
            .tag(0)
            
            Search()
                .tabItem
            {
                Image(systemName: "magnifyingglass")
            }
            .onAppear
            {
                selectedTab = 1
            }
            .tag(1)
            
            NewThreadView(user: sampleUser)
                .tabItem
            {
                Image(systemName: selectedTab == 2 ? "plus" : "plus")
                    .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
            }
            .onAppear
            {
                selectedTab = 2
            }
            .tag(2)
            
            LikedThreadsView(user: sampleUser)
                .tabItem
            {
                Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                    .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
            }
            .onAppear
            {
                selectedTab = 3
            }
            .tag(3)
            
            User(user: sampleUser)
                .tabItem
            {
                Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                    .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
            }
            .onAppear
            {
                selectedTab = 4
            }
            .tag(4)
        }
        .accentColor(.black)
        .navigationBarBackButtonHidden(true) // Hide the back button
    }
}

#Preview
{
    ContentView()
}
