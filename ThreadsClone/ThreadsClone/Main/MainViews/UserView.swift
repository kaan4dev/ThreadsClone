import SwiftUI

struct UserView: View {
    var user: UserModel

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            // Kullanıcının profil fotoğrafı
            Image(user.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                HStack {
                    // Kullanıcı adı
                    Text(user.username)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    // Onaylı kullanıcı simgesi
                    if user.isVerified {
                        Image(systemName: "checkmark.seal.fill") // Alternatif sistem simgesi
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                }
                
                // Kullanıcının tam adı
                Text(user.fullName)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            
            Spacer() // Takip düğmesinin sağa yaslanmasını sağlar
            
            Button(action: {
                // Follow butonuna tıklanınca yapılacak işlem
                print("Follow button tapped for \(user.username)")
                // Add actual follow functionality here
            }) {
                Text("Follow")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            .padding(8)
            .padding(.horizontal, 10)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
        }
        .padding(.horizontal)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: UserModel(
            username: "dbook",
            fullName: "Devin Booker",
            imageName: "user",
            isVerified: true,
            likedThreads: [], // likedThreads should come before threadMessage
            threadMessage: "I'm Booker"
        ))
    }
}
