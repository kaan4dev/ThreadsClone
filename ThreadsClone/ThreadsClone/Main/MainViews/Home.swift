import SwiftUI

struct Home: View
{
    let users: [UserModel] = DataLoader.loadUsers()

    var body: some View
    {
        NavigationView 
        {
            VStack 
            {
                Header
                
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 5) 
                    {
                        ForEach(users) 
                        { user in
                            FeedView(user: user)
                                .padding(.bottom, 0)
                        }
                    }
                    .padding(.top, 0)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    var Header: some View 
    {
        HStack 
        {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 35)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview 
{
    Home()
}
