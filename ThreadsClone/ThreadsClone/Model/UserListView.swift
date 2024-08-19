import SwiftUI

struct UserListView: View
{
    @StateObject private var viewModel = UserViewModel() // ViewModel kullanımı

    var body: some View
    {
        VStack
        {
            ForEach(viewModel.users)
            { user in
                UserView(user: user)
            }
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
