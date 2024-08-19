import SwiftUI

struct NewThreadView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var threadText: String = ""
    var user: UserModel
    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.black)
                        .accessibilityLabel("Cancel")
                }
                
                Spacer()
                
                Text("New Thread")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    if !threadText.isEmpty {
                        viewModel.addThread(for: user, threadText: threadText)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Post")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(threadText.isEmpty ? Color.gray.opacity(0.3) : Color.black)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .disabled(threadText.isEmpty)
                .accessibilityLabel("Post Thread")
            }
            .padding()

            Divider()
            
            HStack(alignment: .top) {
                UserProfileImage(imageName: user.imageName)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(user.username)
                            .fontWeight(.bold)
                        
                        if user.isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.blue)
                                .font(.caption)
                        }
                    }
                    
                    TextField("What's your new thread about?", text: $threadText, axis: .vertical)
                        .padding(.top, 8)
                        .accessibilityLabel("Thread Text Field")
                }
                
                Spacer()
                
                Button(action: {
                    // Placeholder for additional action
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title2)
                        .accessibilityLabel("Add More Options")
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 20) {
                Image(systemName: "photo.on.rectangle.angled")
                Image(systemName: "bubble.left")
                Image(systemName: "location")
                Image(systemName: "number")
                Image(systemName: "text.justify")
            }
            .font(.title2)
            .foregroundColor(.gray)
            .padding(.horizontal)
            .padding(.top, 8)
            
            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct UserProfileImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .background(Color.gray.opacity(0.2))
            .accessibilityLabel("User Profile Image")
    }
}
