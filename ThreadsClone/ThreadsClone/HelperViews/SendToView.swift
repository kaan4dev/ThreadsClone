import SwiftUI

struct SendToView: View
{
    @State private var searchText: String = ""
    @State private var selectedUser: UserModel? = nil
    @Environment(\.presentationMode) var presentationMode

    let message: String = "Discovered a new coffee shop in my neighborhood and I'm interested..."
    let users: [UserModel]

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
        VStack
        {
            HStack
            {
                Button("Cancel")
                {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
                
                Text("Send to")
                    .font(.headline)
                
                Spacer()
            }
            .padding()
            
            HStack
            {
                Image(selectedUser?.imageName ?? "defaultImage")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text(message)
                    .font(.callout)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding([.leading, .trailing])
            
            HStack
            {
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(12)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            
            // User list
            ScrollView
            {
                VStack(spacing: 20)
                {
                    ForEach(filteredUsers)
                    { user in
                        HStack
                        {
                            Image(user.imageName) // Use user's image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading)
                            {
                                Text(user.username)
                                    .font(.headline)
                                
                                Text(user.fullName)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Button(action:
                            {
                                selectedUser = user // Select user for sending
                            })
                            {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            
            Spacer()
            
            HStack
            {
                TextField("Write a message...", text: .constant(""))
                    .padding(12)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                
                Button("Send")
                {
                    // Action for sending the message
                    if let selectedUser = selectedUser
                    {
                        print("Sending message to \(selectedUser.username)")
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding()
            }
        }
        .presentationDetents([.medium]) // This makes the sheet scrollable
    }
}
