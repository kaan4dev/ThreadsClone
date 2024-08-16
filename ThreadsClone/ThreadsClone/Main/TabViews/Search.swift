import SwiftUI

struct Search: View
{
    @State private var searchText: String = ""
    let users: [UserModel] = DataLoader.loadUsers()
    
    var filteredUsers: [UserModel]
    {
        if searchText.isEmpty
        {
            return users
        }
        else
        {
            return users.filter
            {
                $0.username.lowercased().contains(searchText.lowercased()) ||
                $0.fullName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                Text("")
                    .navigationTitle("Search")
                
                ScrollView
                {
                    VStack(spacing: 30)
                    {
                        HStack
                        {
                            Image(systemName: "magnifyingglass")
                            
                            TextField("Search", text: $searchText)
                        }
                        .padding(12)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                        
                        ScrollView
                        {
                            VStack(spacing: 30)
                            {
                                ForEach(filteredUsers)
                                { user in
                                    NavigationLink(destination: ProfileView(user: user))
                                    {
                                        UserView(user: user)
                                    }
                                }
                            }
                            .padding(.top)
                        }
                    }
                }
            }
        }
    }
}

struct Search_Previews: PreviewProvider
{
    static var previews: some View
    {
        Search()
    }
}
