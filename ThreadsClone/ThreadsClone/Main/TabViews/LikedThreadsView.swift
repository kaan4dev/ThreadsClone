import SwiftUI

struct LikedThreadsView: View
{
    var user: UserModel
    
    var body: some View
    {
        VStack
        {
            Text("Liked Threads")
                .font(.largeTitle)
                .padding()
            
            ScrollView
            {
                VStack(alignment: .leading, spacing: 20)
                {
                    ForEach(user.likedThreads, id: \.self)
                    { thread in
                        Text(thread)
                            .font(.body)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
}

struct LikedThreadsView_Previews: PreviewProvider
{
    static var previews: some View
    {
        let exampleUser = UserModel(
            username: "lukadoncic",
            fullName: "Luka Dončić",
            imageName: "user10",
            isVerified: true,
            threadMessage: "I'm Dončić",
            likedThreads: ["Thread 1", "Thread 2", "Thread 3"]
        )
        
        return LikedThreadsView(user: exampleUser)
    }
}
