import SwiftUI
import SlidingTabView

struct User: View
{
    @State private var selectedIndex = 0
    var user: UserModel

    var body: some View
    {
        NavigationView
        {
            VStack
            {
                HStack
                {
                    Image(systemName: "globe")
                        .imageScale(.large)
                    
                    Spacer()
                    
                    Image(systemName: "line.3.horizontal")
                        .imageScale(.large)
                }
                .padding(.horizontal)
                
                ScrollView
                {
                    VStack(alignment: .leading, spacing: 20)
                    {
                        ProfileView
                        
                        FollowersView
                        
                        HStack
                        {
                            NavigationLink(destination: Profile())
                            {
                                Text("Edit Profile")
                                    .font(.callout)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.white)
                            
                            Button
                            {
                                // Action for sharing the profile
                            } label:
                            {
                                Text("Share Profile")
                                    .font(.callout)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.5)))
                        }
                        
                        VStack
                        {
                            SlidingTabView(selection: $selectedIndex, tabs: ["Threads", "Replies"])
                            
                            if selectedIndex == 0
                            {
                                // Display threads or liked threads
                                ForEach(user.likedThreads, id: \.self)
                                { thread in
                                    FeedView(user: user) // You may need a different view for threads
                                }
                            }
                        }
                        .foregroundColor(.black)
                        .accentColor(.black)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("User Profile")
        }
    }
    
    var ProfileView: some View
    {
        HStack(alignment: .top)
        {
            VStack(alignment: .leading, spacing: 10)
            {
                Text(user.fullName)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("@\(user.username)")
                    .font(.callout)
                    .underline()
                
                Text(user.threadMessage)
                    .font(.callout)
            }
            
            Image(user.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
        }
    }
    
    var FollowersView: some View
    {
        HStack
        {
            ForEach(0..<3)
            { _ in
                Image(user.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white))
                    .padding(.leading, -15)
            }
            
            Text("23 Followers")
                .font(.callout)
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 15)
    }
}

#Preview
{
    // Example user for preview
    let exampleUser = UserModel(
        username: "lukadoncic",
        fullName: "Luka Dončić",
        imageName: "user10",
        isVerified: true,
        threadMessage: "I'm Dončić",
        likedThreads: ["Thread 1", "Thread 2", "Thread 3"]
    )
    
    return User(user: exampleUser)
}
