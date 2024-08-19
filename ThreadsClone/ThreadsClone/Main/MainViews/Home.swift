import SwiftUI

struct Home: View {
    @StateObject private var viewModel = UserViewModel()  // ViewModel

    var body: some View {
        NavigationView {
            VStack {
                Header
                
                // Main content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(viewModel.users) { user in
                            FeedCard(user: user)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground)) // Adjust background color
            .navigationTitle("Home")
            .navigationBarHidden(true) // Hide navigation bar
        }
        .onAppear {
            viewModel.loadUsersFromFirestore()  // Load data from Firestore
        }
    }
    
    var Header: some View {
        HStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 35)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white) // Background for header
        .shadow(radius: 2) // Add shadow for better separation
    }
}

struct FeedCard: View {
    let user: UserModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                AsyncImage(url: URL(string: user.imageName)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    case .failure:
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(user.fullName)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(user.username)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.white) // Background for each card
            .cornerRadius(8)
            .shadow(radius: 4)
        }
        .padding(.horizontal)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
