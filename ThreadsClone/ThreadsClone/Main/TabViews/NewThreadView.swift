import SwiftUI

struct NewThreadView: View
{
    @Environment(\.presentationMode) var presentationMode
    @State private var threadText: String = ""
    var user: UserModel
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                Button("Cancel")
                {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.black)
                
                Spacer()
                
                Text("New thread")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action:
                {
                    print("Thread Posted: \(threadText)")
                    presentationMode.wrappedValue.dismiss()
                })
                {
                    Text("Post")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(threadText.isEmpty ? Color.gray.opacity(0.3) : Color.black)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .disabled(threadText.isEmpty)
            }
            .padding()
            
            Divider()
            
            HStack(alignment: .top)
            {
                Image(user.imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading)
                {
                    HStack
                    {
                        Text(user.username)
                            .fontWeight(.bold)
                        
                        if user.isVerified
                        {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.blue)
                                .font(.caption)
                        }
                    }
                    
                    TextField("What is your book of the year?", text: $threadText, axis: .vertical)
                        .padding(.top, 8)
                }
                
                Spacer()
                
                Button(action:
                {
                    // Action for adding to thread
                })
                {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 20)
            {
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

struct NewThreadView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NewThreadView(user: UserModel(
            username: "dbook",
            fullName: "Devin Booker",
            imageName: "user",
            isVerified: true,
            threadMessage: "I'm Booker",
            likedThreads: ["Thread 1", "Thread 2", "Thread 3"]
        ))
    }
}
