import SwiftUI
import SlidingTabView

struct User: View {
    @State private var selectedIndex = 0
    var user: UserModel

    var body: some View {
        NavigationView {
            VStack {
                headerView

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        profileView
                        followersView
                        actionButtons

                        SlidingTabView(selection: $selectedIndex, tabs: ["Threads", "Liked Threads"])

                        if selectedIndex == 0 {
                            // Display user's threads using FeedSectionView
                            FeedSectionView(user: user)
                        } else {
                            // Display liked threads using LikedThreadsSectionView
                            LikedThreadsSectionView(user: user)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("User Profile")
            .navigationBarHidden(true)
        }
    }

    var headerView: some View {
        HStack {
            Image(systemName: "globe")
                .imageScale(.large)

            Spacer()

            Image(systemName: "line.3.horizontal")
                .imageScale(.large)
        }
        .padding(.horizontal)
    }

    var profileView: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                Text(user.fullName)
                    .font(.title)
                    .fontWeight(.semibold)

                Text("@\(user.username)")
                    .font(.callout)
                    .underline()

                Text(user.threadMessage)
                    .font(.callout)
            }

            Spacer()

            Image(user.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
        }
    }

    var followersView: some View {
        HStack {
            ForEach(0..<3) { _ in
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

    var actionButtons: some View {
        HStack {
            NavigationLink(destination: ProfileView(user: user)) {
                Text("Edit Profile")
                    .font(.callout)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)

            Button(action: {
                // Action for sharing the profile
            }) {
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
    }
}

// Assume FeedSectionView and LikedThreadsSectionView are defined elsewhere, as previously shown.

struct User_Previews: PreviewProvider {
    static var previews: some View {
        let exampleUser = UserModel(
            id: UUID().uuidString,
            username: "lukadoncic",
            fullName: "Luka Dončić",
            imageName: "user10",
            isVerified: true,
            likedThreads: ["Thread 1", "Thread 2", "Thread 3"],
            threads: ["Thread 1", "Thread 2", "Thread 3"],
            threadMessage: "I'm Dončić"
        )

        User(user: exampleUser)
    }
}
