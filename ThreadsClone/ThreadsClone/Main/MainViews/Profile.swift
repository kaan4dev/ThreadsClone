import SwiftUI

struct Profile: View 
{
    @State var name: String = ""
    @State var userName: String = ""
    @State var img: String = ""
    @State var bio: String = ""
    @State var link: String = ""
    
    var body: some View
    {
        VStack(spacing: 10)
        {
            Text("Profile")
                .font(.system(size: 26, weight: .bold))
                .padding(.top)
            
            Text("Customize your Threads profile")
                .font(.system(size: 12))
                .opacity(0.6)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10)
            {
                HStack
                {
                    VStack(alignment: .leading)
                    {
                        Text("Name")
                            .font(.system(size: 14))
                        
                        TextField("full Name", text: $name)
                            .font(.system(size: 14))
                    }
                    
                    AsyncImage(url: URL(string: img))
                    {
                        image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 50)
                            .clipShape(Circle())
                        
                    }
                placeholder:
                    {
                        Image(systemName: "person.badge.plus")
                            .background(.gray.opacity(0.2))
                            .padding()
                            .clipShape(Circle())
                    }
                }
                
                Text("User Name")
                    .font(.system(size: 14))
                
                TextField("@username", text: $name)
                    .font(.system(size: 14))
                
                Divider()
                
                Text("Bio")
                    .font(.system(size: 14))
                
                TextField("bio", text: $name)
                    .font(.system(size: 14))
                
                Divider()
                
                Text("Link")
                    .font(.system(size: 14))
                
                TextField("link", text: $name)
                    .font(.system(size: 14))
                
                Divider()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(.black.opacity(0.3)))
            .padding(.horizontal)
            
            Button
            {
                
            } 
            label:
            {
                Text("Import from Google")
                    .font(.system(size: 16))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .foregroundColor(.white)
            .padding()
            
            Spacer()
        }
    }
}

#Preview 
{
    Profile()
}
