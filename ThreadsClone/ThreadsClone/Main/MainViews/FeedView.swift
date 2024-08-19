import SwiftUI

struct FeedView: View
{
    @ObservedObject var viewModel: UserViewModel
    @State private var selectedUser: UserModel?
    @State private var isNavigating: Bool = false

    var body: some View
    {
        NavigationStack
        {
            List(viewModel.users) { user in
                VStack(alignment: .leading, spacing: 12)
                {
                    HStack(alignment: .top, spacing: 12)
                    {
                        // Use a Button for the profile image
                        Button(action: {
                            navigateToProfile(for: user)
                        }) {
                            Image(user.imageName) // Load image directly from assets
                                .resizable()
                                .aspectRatio(contentMode: .fill) // Maintain aspect ratio while filling the frame
                                .frame(width: 40, height: 40) // Image size
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1)) // Lighter border
                                .clipped() // Clip the image to prevent overflow
                        }
                        .buttonStyle(PlainButtonStyle())

                        VStack(alignment: .leading, spacing: 8)
                        {
                            HStack
                            {
                                Text(user.fullName)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)

                                if user.isVerified
                                {
                                    Image(systemName: "checkmark.seal.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 14, height: 14)
                                        .foregroundColor(.blue)
                                }

                                Spacer()

                                Text("3m") // You can adjust this to be dynamic if needed
                                    .font(.caption)
                                    .foregroundColor(Color.gray)

                                Image(systemName: "ellipsis")
                                    .foregroundColor(Color.gray)
                            }
                            // Display the first thread
                            if let firstThread = user.threads.first
                            {
                                Text(firstThread)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                    .padding(8)
                                    .background(Color(.systemGray6)) // Subtle background color
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white.opacity(0.1), lineWidth: 1) // Subtle border
                                    )
                                    .frame(maxWidth: .infinity, alignment: .leading) // Ensure full width
                            }

                            HStack(spacing: 24)
                            {
                                Button(action: {
                                    likeThread(for: user)
                                }) {
                                    Image(systemName: "heart")
                                        .foregroundColor(.gray)
                                }

                                Button(action: {
                                    messageUser(user)
                                }) {
                                    Image(systemName: "message")
                                        .foregroundColor(.gray)
                                }

                                Button(action: {
                                    shareThread(user.threadMessage)
                                }) {
                                    Image(systemName: "arrowshape.turn.up.left")
                                        .foregroundColor(.gray)
                                }

                                Button(action: {
                                    sendPaperPlane(user.threadMessage)
                                }) {
                                    Image(systemName: "paperplane")
                                        .foregroundColor(.gray)
                                }
                            }
                            .font(.title3)
                            .padding(.top, 4) // Add padding to ensure buttons are not too close to the text
                        }
                    }
                    .padding(8) // Adjust padding for a more compact layout
                    .background(Color.white) // Background for each card
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: Color.gray.opacity(0.1), radius: 6, x: 0, y: 2) // Lighter shadow
                }
                .padding(.horizontal)
                .padding(.vertical, 4) // Adjust vertical padding
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(PlainListStyle()) // Remove default list styling

            // NavigationLink to the ProfileView
            .navigationDestination(isPresented: $isNavigating) {
                if let user = selectedUser
                {
                    ProfileView(user: user)
                }
            }
        }
    }

    // Action methods
    private func navigateToProfile(for user: UserModel)
    {
        // Set the selected user and trigger navigation
        selectedUser = user
        isNavigating = true
    }

    private func likeThread(for user: UserModel)
    {
        // Add logic to like the thread
        print("Liked thread for \(user.fullName)")
    }

    private func messageUser(_ user: UserModel)
    {
        // Add logic to message the user
        print("Message sent to \(user.fullName)")
    }

    private func shareThread(_ message: String)
    {
        // Add logic to share the thread
        print("Thread shared: \(message)")
    }

    private func sendPaperPlane(_ message: String)
    {
        // Add logic to send a paper plane
        print("Paper plane sent with message: \(message)")
    }
}

struct FeedView_Previews: PreviewProvider
{
    static var previews: some View
    {
        FeedView(viewModel: UserViewModel()) // Provide a sample UserViewModel instance
    }
}
