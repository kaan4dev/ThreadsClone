import SwiftUI

struct Search: View {
    @State private var searchText: String = ""
    @StateObject private var viewModel = UserViewModel()

    var filteredUsers: [UserModel] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter {
                $0.username.lowercased().contains(searchText.lowercased()) ||
                $0.fullName.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("")
                    .navigationTitle("Search")

                ScrollView {
                    VStack(spacing: 30) {
                        HStack {
                            Image(systemName: "magnifyingglass")

                            TextField("Search", text: $searchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(12)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)

                        VStack(spacing: 30) {
                            ForEach(filteredUsers) { user in
                                NavigationLink(destination: ProfileView(user: user)) {
                                    UserView(user: user)
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .onAppear {
                viewModel.loadUsersFromFirestore()
            }
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
