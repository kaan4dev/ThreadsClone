import SwiftUI

struct ProfileView: View
{
    let user: UserModel
    @State private var selectedIndex = 0

    var body: some View
    {
        VStack
        {
            VStack(spacing: 20)
            {
                VStack(spacing: 20)
                {
                    Image(user.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    
                    Text(user.fullName)
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(user.username)
                        .font(.callout)
                        .underline()
                    
                    if user.isVerified
                    {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                    }
                }
                
                .padding()
            }
            
            TabView(selection: $selectedIndex)
            {
                FeedSectionView(user: user)
                    .tag(0)
                    .tabItem
                    {
                        Text("Threads")
                    }
                
                LikedThreadsSectionView(user: user)
                    .tag(1)
                    .tabItem
                    {
                        Text("Liked Threads")
                    }
            }
            .foregroundColor(.black)
            .accentColor(.black)
        }
        .navigationTitle(user.username)
    }
}

struct FeedSectionView: View
{
    let user: UserModel
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 10)
        {
            Text("Threads")
                .font(.headline)
                .padding(.leading, 5)
            
            ScrollView
            {
                VStack(spacing: 10)
                {
                    FeedView(user: user)
                }
                .padding(5)
            }
        }
    }
}

struct LikedThreadsSectionView: View
{
    let user: UserModel
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 10)
        {
            Text("Liked Threads")
                .font(.headline)
                .padding(.leading, 5)
            
            ScrollView
            {
                VStack(alignment: .leading, spacing: 10)
                {
                    ForEach(user.likedThreads, id: \.self)
                    { thread in
                        Text(thread)
                            .font(.subheadline)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding(5)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationView
        {
            ProfileView(user: UserModel(
                username: "dbook",
                fullName: "Devin Booker",
                imageName: "user",
                isVerified: true,
                threadMessage: "I'm Booker",
                likedThreads: [
                    "The Phoenix Suns are on fire!",
                    "Top 10 shooting guards of all time",
                    "NBA playoff predictions 2024"
                ]
            ))
        }
    }
}
