import SwiftUI

struct ProfileView: View {
    let user: UserModel
    @State private var selectedIndex = 0
    @State private var isImageFullScreen = false // State to control full-screen image

    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 20) {
                    // Profile Image
                    Button(action: {
                        isImageFullScreen.toggle() // Show full-screen image on tap
                    }) {
                        Image(user.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove default button styling

                    // Profile Details
                    Text(user.fullName)
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(user.username)
                        .font(.callout)
                        .underline()

                    if user.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                    }
                }
                .padding()

                // Tabs for Threads and Liked Threads
                TabView(selection: $selectedIndex) {
                    FeedSectionView(user: user) // Pass the user object
                        .tag(0)
                        .tabItem {
                            Label("Threads", systemImage: "list.bullet")
                        }

                    LikedThreadsSectionView(user: user)
                        .tag(1)
                        .tabItem {
                            Label("Liked Threads", systemImage: "heart.fill")
                        }
                }
                .foregroundColor(.black)
                .accentColor(.black)
            }

            // Full-screen image overlay
            if isImageFullScreen {
                ZStack(alignment: .topTrailing) {
                    Color.black.opacity(0.8).edgesIgnoringSafeArea(.all) // Dark background

                    Image(user.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onTapGesture {
                            isImageFullScreen.toggle() // Hide full-screen image on tap
                        }

                    Button(action: {
                        isImageFullScreen.toggle()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
        }
        .navigationTitle(user.username)
    }
}

struct FeedSectionView: View {
    let user: UserModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Threads")
                .font(.headline)
                .padding(.leading, 5)

            ScrollView {
                LazyVStack(spacing: 10) { // Use LazyVStack for better performance
                    ForEach(user.threads, id: \.self) { thread in
                        FeedThreadView(user: user, threadMessage: thread)
                    }
                }
                .padding(5)
            }
        }
    }
}

struct FeedThreadView: View {
    let user: UserModel
    let threadMessage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                Image(user.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1))
                    .clipped()

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(user.fullName)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)

                        if user.isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                                .foregroundColor(.blue)
                        }

                        Spacer()

                        Text("3m") // Example timestamp
                            .font(.caption)
                            .foregroundColor(Color.gray)

                        Image(systemName: "ellipsis")
                            .foregroundColor(Color.gray)
                    }

                    // Display the thread message
                    Text(threadMessage)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineLimit(nil)
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack(spacing: 24) {
                        Button(action: {
                            print("Liked thread")
                        }) {
                            Image(systemName: "heart")
                                .foregroundColor(.gray)
                        }

                        Button(action: {
                            print("Message user")
                        }) {
                            Image(systemName: "message")
                                .foregroundColor(.gray)
                        }

                        Button(action: {
                            print("Share thread")
                        }) {
                            Image(systemName: "arrowshape.turn.up.left")
                                .foregroundColor(.gray)
                        }

                        Button(action: {
                            print("Send paper plane")
                        }) {
                            Image(systemName: "paperplane")
                                .foregroundColor(.gray)
                        }
                    }
                    .font(.title3)
                    .padding(.top, 4)
                }
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.gray.opacity(0.1), radius: 6, x: 0, y: 2)
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct LikedThreadsSectionView: View {
    let user: UserModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Liked Threads")
                .font(.headline)
                .padding(.leading, 5)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) { // Use LazyVStack for better performance
                    ForEach(user.likedThreads, id: \.self) { thread in
                        FeedThreadView(user: user, threadMessage: thread)
                    }
                }
                .padding(5)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(user: UserModel(
                username: "dbook",
                fullName: "Devin Booker",
                imageName: "user",
                isVerified: true,
                likedThreads: [
                    "The Phoenix Suns are on fire!",
                    "Top 10 shooting guards of all time",
                    "NBA playoff predictions 2024"
                ],
                threads: ["I'm Booker", "Another thread", "More threads"],
                threadMessage: "I'm Booker"
            ))
        }
    }
}
