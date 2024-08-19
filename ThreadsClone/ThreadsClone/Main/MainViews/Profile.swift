import SwiftUI

struct Profile: View {
    @State private var name: String = ""
    @State private var userName: String = ""
    @State private var img: String = ""
    @State private var bio: String = ""
    @State private var link: String = ""

    var body: some View {
        VStack(spacing: 10) {
            Text("Profile")
                .font(.system(size: 26, weight: .bold))
                .padding(.top)

            Text("Customize your Threads profile")
                .font(.system(size: 12))
                .opacity(0.6)

            Spacer()

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.system(size: 14))

                        TextField("Full Name", text: $name)
                            .font(.system(size: 14))
                    }

                    AsyncImage(url: URL(string: img)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        case .failure:
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        case .empty:
                            ProgressView()
                                .frame(width: 50, height: 50)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                Text("User Name")
                    .font(.system(size: 14))

                TextField("@username", text: $userName)
                    .font(.system(size: 14))

                Divider()

                Text("Bio")
                    .font(.system(size: 14))

                TextField("Bio", text: $bio)
                    .font(.system(size: 14))

                Divider()

                Text("Link")
                    .font(.system(size: 14))

                TextField("Link", text: $link)
                    .font(.system(size: 14))

                Divider()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black.opacity(0.3)))
            .padding(.horizontal)

            Button(action: {
                // Action for importing from Google
            }) {
                Text("Import from Google")
                    .font(.system(size: 16))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .foregroundColor(.white)
            .padding()

            Spacer()
        }
        .background(Color(UIColor.systemBackground)) // Background color
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
