import SwiftUI

struct FeedView: View
{
    var user: UserModel
    
    var body: some View
    {
        HStack(alignment: .top, spacing: 15)
        {
            VStack
            {
                NavigationLink(destination: ProfileView(user: user))
                {
                    Image(user.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                        .contentShape(Circle())
                        .buttonStyle(PlainButtonStyle())
                }
            }
            
            VStack(alignment: .leading, spacing: 15)
            {
                HStack
                {
                    Text(user.fullName)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    if user.isVerified
                    {
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text("3m")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        
                    Image(systemName: "ellipsis")
                        .foregroundColor(Color.gray)
                }
                
                Text(user.threadMessage)
                    .font(.body)
                    .foregroundColor(.primary)
                
                HStack(spacing: 20)
                {
                    Button(action: {
                        // Add action for like
                    })
                    {
                        Image(systemName: "heart")
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        // Add action for message
                    })
                    {
                        Image(systemName: "message")
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        // Add action for share
                    })
                    {
                        Image(systemName: "arrowshape.turn.up.left")
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        // Add action for paperplane
                    })
                    {
                        Image(systemName: "paperplane")
                            .foregroundColor(.gray)
                    }
                }
                .font(.title2)
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
    }
}

#Preview
{
    FeedView(user: UserModel(
        id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440000")!,
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
