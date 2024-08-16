import SwiftUI

struct UserListView: View
{
    @State private var users: [UserModel] = []

    var body: some View
    {
        VStack
        {
            ForEach(users)
            { user in
                UserView(user: user)
            }
        }
        .onAppear
        {
            self.users = DataLoader.loadUsers()
        }
    }
}

struct UserListView_Previews: PreviewProvider
{
    static var previews: some View
    {
        UserListView()
    }
}
