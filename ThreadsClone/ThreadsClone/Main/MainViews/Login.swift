import SwiftUI

struct Login: View {
    @Binding var showLoginView: Bool
    @State private var navigateToContentView = false

    var body: some View {
        NavigationStack {
            VStack {
                Image("Pattern")
                    .resizable()
                    .edgesIgnoringSafeArea(.top)
                
                Spacer()
                
                Button(action: {
                    navigateToContentView = true
                }) {
                    HStack {
                        Text("Continue with Google")
                            .font(.system(size: 16))
                        
                        Spacer()
                        
                        Image("google")
                            .resizable().scaledToFit()
                            .frame(width: 30)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.white)
                    .clipShape(Capsule())
                    .padding()
                    .shadow(color: .black.opacity(0.1), radius: 48, x: 0, y: 4)
                }
                .padding()
            }
            .navigationBarHidden(true) // Hide navigation bar on Login
            .navigationDestination(isPresented: $navigateToContentView) {
                ContentView()
            }
        }
    }
}

#Preview {
    Login(showLoginView: .constant(false))
}
